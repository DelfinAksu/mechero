from flask import Blueprint, render_template
from flask_login import login_required, current_user
from app.models import Appointment, Vehicle, User, MaintenanceType, Dealership, EmployeeSchedule, Employee
from app import db
from flask import jsonify

bp = Blueprint('employee', __name__)

@bp.route('/dashboard')
@login_required
def dashboard():
    return render_template('employee/dashboard.html')

@bp.route('/appointments')
@login_required
def appointments():
    if not current_user.get_id().startswith("e"):
        return "Unauthorized access", 403

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
        return f"Error: {e}", 400


@bp.route('/appointments/json')
@login_required
def appointments_json():
    if not current_user.get_id().startswith("e"):
        return jsonify([])

    emp_id = int(current_user.get_id()[1:])
    employee = Employee.query.get(emp_id)
    schedules = EmployeeSchedule.query.filter_by(employee_id=emp_id).all()

    events = []
    for s in schedules:
        a = s.appointment
        if a and a.status != 'Cancelled' and a.dealership_id == employee.dealership_id:
            events.append({
                "title": f"{a.vehicle.brand} {a.vehicle.model} ({a.maintenance_type.type_name})",
                "start": f"{a.a_date}T{a.a_time}",
                "extendedProps": {
                    "date": a.a_date.strftime('%Y-%m-%d'),
                    "time": a.a_time.strftime('%H:%M'),
                    "customer": f"{a.user.u_fname} {a.user.u_lname}",
                    "type": a.maintenance_type.type_name,
                    "plate": a.vehicle.plate_number,
                    "price": a.price
                }
            })

    return jsonify(events)