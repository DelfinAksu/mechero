from flask import Blueprint, render_template, request, redirect, url_for, flash
from flask_login import login_required, current_user
from app import db
from app.models import Vehicle, Appointment
from datetime import datetime

bp = Blueprint('user', __name__)

@bp.route('/dashboard')
@login_required
def dashboard():
    return render_template('user/dashboard.html', user=current_user)

@bp.route('/appointments')
def appointments():
    user_appts = Appointment.query.filter_by(user_id=current_user.id).all()
    return render_template('user/appointments.html', appointments=user_appts)

@bp.route('/appointments/book', methods=['GET', 'POST'])
@login_required
def book_appointment():
    if request.method == 'POST':
        try:
            vehicle_id = int(request.form['vehicle_id'])
            date_str = request.form['date']
            time_str = request.form['time']

            date_obj = datetime.strptime(date_str, "%Y-%m-%d").date()
            time_obj = datetime.strptime(time_str, "%H:%M").time()

            appointment = Appointment(
                vehicle_id=vehicle_id,
                user_id=current_user.id,
                date=date_obj,
                time=time_obj,
                status='Scheduled',
                price=None
            )
            db.session.add(appointment)
            db.session.commit()
            flash("Randevu başarıyla oluşturuldu!", "success")
            return redirect(url_for('user.dashboard'))

        except Exception as e:
            db.session.rollback()  # 🔥 BU DA GEREKLİ ARTIK
            flash(f"Bir hata oluştu: {e}", "danger")

    user_vehicles = current_user.vehicles
    return render_template('user/book_appointment.html', vehicles=user_vehicles)

@bp.route('/profile')
def profile():
    return render_template('user/profile.html')

@bp.route('/update-profile')
def update_profile():
    return render_template('user/update_profile.html')

@bp.route('/vehicles')
@login_required
def vehicles():
    user_vehicles = Vehicle.query.filter_by(user_id=current_user.id).all()
    return render_template('user/vehicles.html', vehicles=user_vehicles)

@bp.route('/vehicles/add', methods=['GET', 'POST'])
@login_required
def add_vehicle():
    if request.method == 'POST':
        vehicle = Vehicle(
            plate_number=request.form['plate_number'],
            brand=request.form['brand'],
            model=request.form['model'],
            year=int(request.form['year']),
            fuel_type=request.form['fuel_type'],
            mileage=int(request.form['mileage']),
            user_id=current_user.id
        )
        db.session.add(vehicle)
        db.session.commit()
        flash("Araç başarıyla eklendi!", "success")
        return redirect(url_for('user.vehicles'))
    return render_template('user/add_vehicle.html')