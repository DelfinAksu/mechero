from flask import Blueprint, render_template

bp = Blueprint('user', __name__)

@bp.route('/dashboard')
def dashboard():
    return render_template('user/dashboard.html')

@bp.route('/appointments')
def appointments():
    return render_template('user/appointments.html')

@bp.route('/book')
def book_appointment():
    return render_template('user/book_appointment.html')

@bp.route('/profile')
def profile():
    return render_template('user/profile.html')

@bp.route('/update-profile')
def update_profile():
    return render_template('user/update_profile.html')
