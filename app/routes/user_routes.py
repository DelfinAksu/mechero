from flask import Blueprint, render_template, request, redirect, url_for, flash
from flask_login import login_required, current_user
from app import db
from app.models import Vehicle, Appointment, City, Dealership, MaintenanceType
from datetime import datetime

bp = Blueprint('user', __name__)

@bp.route('/dashboard')
@login_required
def dashboard():
    return render_template('user/dashboard.html', user=current_user)

@bp.route('/appointments')
@login_required
def appointments():
    user_appts = Appointment.query.filter_by(user_id=current_user.user_id).all()

    now_dt = datetime.now()
    for appt in user_appts:
        if appt.status == 'Scheduled' and datetime.combine(appt.a_date, appt.a_time) < now_dt:
            appt.status = 'Completed'
            db.session.commit()

    return render_template('user/appointments.html', appointments=user_appts, now=datetime.now)

@bp.route('/appointments/cancel/<int:appointment_id>', methods=['POST'])
@login_required
def cancel_appointment(appointment_id):
    appt = Appointment.query.get_or_404(appointment_id)
    if appt.user_id != current_user.user_id:
        flash("Bu randevuyu iptal etme yetkiniz yok.", "danger")
        return redirect(url_for('user.appointments'))

    if appt.status == 'Scheduled' and datetime.combine(appt.a_date, appt.a_time) > datetime.now():
        appt.status = 'Cancelled'
        db.session.commit()
        flash("Randevu başarıyla iptal edildi.", "info")
    else:
        flash("Randevu iptal edilemez.", "warning")

    return redirect(url_for('user.appointments'))


@bp.route('/appointments/book', methods=['GET', 'POST'])
@login_required
def book_appointment():
    cities = City.query.all()
    maintenance_types = MaintenanceType.query.all()

    selected_city_id = request.form.get('city_id') or request.args.get('city_id') or str(cities[0].city_id)
    selected_dealership_id = request.form.get('dealership_id')

    dealerships = []
    dealerships_json = []

    if selected_city_id:
        dealerships = Dealership.query.filter_by(city_id=selected_city_id).all()
        dealerships_json = [
            {
                'id': d.dealership_id,
                'name': d.d_name,
                'street': d.address,
                'number': "",  # Varsa ayrıntı girilebilir
                'latitude': d.latitude,
                'longitude': d.longitude
            }
            for d in dealerships
        ]

    if request.method == 'POST' and request.form.get('date') and request.form.get('time'):
        try:
            vehicle_id = int(request.form['vehicle_id'])
            date_str = request.form['date']
            time_str = request.form['time']
            dealership_id = int(request.form['dealership_id'])
            type_id = int(request.form['type_id'])

            date_obj = datetime.strptime(date_str, "%Y-%m-%d").date()
            time_obj = datetime.strptime(time_str, "%H:%M").time()

            appointment = Appointment(
                vehicle_id=vehicle_id,
                user_id=current_user.user_id,
                dealership_id=dealership_id,
                type_id=type_id,
                a_date=date_obj,
                a_time=time_obj,
                status='Scheduled',
                price=0.0
            )

            db.session.add(appointment)
            db.session.commit()

            print("✅ Randevu eklendi:", appointment)
            flash("Randevu başarıyla oluşturuldu!", "success")
            return redirect(url_for('user.dashboard'))

        except Exception as e:
            db.session.rollback()
            print("❌ DB HATASI:", e)
            flash(f"Bir hata oluştu: {e}", "danger")

    user_vehicles = current_user.vehicles
    return render_template(
        'user/book_appointment.html',
        vehicles=user_vehicles,
        cities=cities,
        dealerships=dealerships,
        dealerships_json=dealerships_json,
        selected_city_id=str(selected_city_id),
        selected_dealership_id=selected_dealership_id,
        maintenance_types=maintenance_types
    )

@bp.route('/profile')
def profile():
    return render_template('user/profile.html')

@bp.route('/update-profile')
def update_profile():
    return render_template('user/update_profile.html')

@bp.route('/vehicles')
@login_required
def vehicles():
    user_vehicles = Vehicle.query.filter_by(user_id=current_user.user_id).all()
    return render_template('user/vehicles.html', vehicles=user_vehicles)

@bp.route('/vehicles/add', methods=['GET', 'POST'])
@login_required
def add_vehicle():
    if request.method == 'POST':
        try:
            print("📥 Form verisi alınıyor...")

            vehicle = Vehicle(
                plate_number=request.form['plate_number'],
                brand=request.form['brand'],
                model=request.form['model'],
                model_year=int(request.form['year']),
                fuel_type=request.form['fuel_type'],
                km=int(request.form['mileage']),
                ownership_count=int(request.form['ownership_count']),
                user_id=current_user.user_id
            )

            print("✅ Araç nesnesi oluşturuldu:", vehicle)

            db.session.add(vehicle)
            db.session.commit()

            flash("Araç başarıyla eklendi!", "success")
            print("🚀 Commit başarılı")
            return redirect(url_for('user.vehicles'))

        except Exception as e:
            db.session.rollback()
            flash(f"Araç eklenirken bir hata oluştu: {e}", "danger")
            print("❌ Commit HATASI:", e)

    return render_template('user/add_vehicle.html')

