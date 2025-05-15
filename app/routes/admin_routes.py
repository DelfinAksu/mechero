from flask import Blueprint, render_template, request
from app.decorators import admin_required
from flask_login import login_required
from app import db
from app.models import Appointment, MaintenanceType, City, Dealership, Employee, EmployeeSchedule
from sqlalchemy import extract, func, text

bp = Blueprint('admin', __name__)

@bp.route('/dashboard')
@admin_required
@login_required
def dashboard():
    return render_template('admin/dashboard.html')

#Most popular maintenance type per month
@bp.route('/admin/top-maintenance')
def top_maintenance():
    month = request.args.get('month', default=5, type=int)
    year = request.args.get('year', default=2025, type=int)

    sql = text("""
        SELECT maintenance_type.type_name, COUNT(*) AS total
        FROM appointment
        JOIN maintenance_type ON appointment.type_id = maintenance_type.type_id
        WHERE EXTRACT(MONTH FROM appointment.a_date) = :month
        AND EXTRACT(YEAR FROM appointment.a_date) = :year
        GROUP BY maintenance_type.type_name
        ORDER BY total DESC;
    """)

    result = db.session.execute(sql, {'month': month, 'year': year}).fetchall()
    # print("RESULT:", result)

    labels = [r[0] for r in result]
    values = [r[1] for r in result]

    return render_template("admin/top_maintenance_type.html",
        labels=labels, values=values, month=month, year=year)


#The month(s) with the highest number of appointments in a city
@bp.route('/admin/city-month-trends', methods=['GET'])
def city_month_trends():
    city_id = request.args.get("city_id", type=int)

    if not city_id:
        first_city = db.session.query(City).first()
        if first_city:
            city_id = first_city.city_id
        else:
            city_id = 1 

    result = db.session.query(
        extract('month', Appointment.a_date).label('month'),
        func.count(Appointment.appointment_id).label("count")
    ).join(Dealership).filter(
        Dealership.city_id == city_id
    ).group_by(
        extract('month', Appointment.a_date)
    ).order_by(
        extract('month', Appointment.a_date)
    ).all()

    month_names = [
        "January", "February", "March", "April", "May", "June",
        "July", "August", "September", "October", "Nowember", "December"
    ]

    labels = [month_names[int(r[0]) - 1] for r in result]
    values = [r[1] for r in result]

    cities = db.session.query(City).all()

    return render_template("admin/city_month_trends.html",
                           labels=labels,
                           values=values,
                           selected_city=city_id,
                           cities=cities)

#The cities with the highest number of appointments
@bp.route('/admin/top-cities', methods=['GET'])
def top_cities():
    year = request.args.get('year', default=2025, type=int)

    result = db.session.query(
        City.city_name,
        func.count(Appointment.appointment_id).label("count")
    ).join(Dealership, Dealership.city_id == City.city_id
    ).join(Appointment, Appointment.dealership_id == Dealership.dealership_id
    ).filter(
        extract('year', Appointment.a_date) == year
    ).group_by(City.city_name).order_by(func.count(Appointment.appointment_id).desc()).all()

    labels = [r[0] for r in result]
    values = [r[1] for r in result]

    return render_template("admin/top_cities.html", labels=labels, values=values, year=year)


#Peak hours for dealerships
@bp.route('/admin/busiest-hours')
def busiest_hours():
    result = db.session.query(
        extract('hour', Appointment.a_time).label('hour'),
        func.count(Appointment.appointment_id).label('count')
    ).group_by(
        extract('hour', Appointment.a_time)
    ).order_by(
        extract('hour', Appointment.a_time)
    ).all()

    labels = [f"{int(r[0]):02d}:00" for r in result]
    values = [r[1] for r in result]

    return render_template("admin/busiest_hours.html",
                           labels=labels,
                           values=values)

#Average Working Hours for Employee
@bp.route('/admin/employee-avg-hours')
def employee_avg_hours():
    result = db.session.query(
        Employee.employee_id,
        Employee.e_fname,
        func.avg(
            func.extract('epoch', EmployeeSchedule.end_time - EmployeeSchedule.start_time) / 3600
        ).label("avg_hours")
    ).join(EmployeeSchedule).group_by(
        Employee.employee_id, Employee.e_fname
    ).order_by(
        func.avg(func.extract('epoch', EmployeeSchedule.end_time - EmployeeSchedule.start_time)).desc()
    ).all()

    labels = [r[1] for r in result]
    values = [round(r[2], 2) for r in result] 

    return render_template("admin/employee_avg_hours.html",
                           labels=labels,
                           values=values)
