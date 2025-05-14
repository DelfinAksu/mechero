from flask import Blueprint, render_template
from flask_login import login_required, current_user
from app.models import Appointment, Vehicle, User, MaintenanceType, Dealership, EmployeeSchedule, Employee
from app import db

bp = Blueprint('employee', __name__)

@bp.route('/dashboard')
@login_required
def dashboard():
    # Buraya takvim veya özetler gelebilir
    return render_template('employee/dashboard.html')

@bp.route('/appointments')
@login_required
def appointments():
    if not current_user.get_id().startswith("e"):
        return "Yetkisiz erişim", 403

    try:
        emp_id = int(current_user.get_id()[1:])
        employee = Employee.query.get(emp_id)

        schedules = EmployeeSchedule.query.filter_by(employee_id=emp_id).all()

        appts = [
            s.appointment for s in schedules
            if s.appointment is not None 
            and s.appointment.status != "Cancelled"
            and s.appointment.dealership_id == employee.dealership_id
        ]

        return render_template("employee/appointments.html", appointments=appts)

    except Exception as e:
        return f"Hata: {e}", 400

