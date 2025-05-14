from datetime import datetime
from flask_login import UserMixin
from werkzeug.security import generate_password_hash, check_password_hash
from app import db, login_manager

@login_manager.user_loader
def load_user(user_id):
    if user_id.startswith("e"):
        return Employee.query.get(int(user_id[1:]))
    else:
        return User.query.get(int(user_id))

class User(UserMixin, db.Model):
    __tablename__ = 'users'

    user_id = db.Column(db.Integer, primary_key=True)
    u_fname = db.Column(db.String(50), nullable=False)
    u_lname = db.Column(db.String(50), nullable=False)
    u_phone = db.Column(db.String(15), nullable=False)
    u_mail = db.Column(db.String(100), unique=True, nullable=False)
    u_password = db.Column(db.String(255), nullable=False)
    u_created_at = db.Column(db.DateTime, default=datetime.utcnow)
    u_updated_at = db.Column(db.DateTime, default=datetime.utcnow)

    vehicles = db.relationship('Vehicle', backref='user', cascade="all, delete-orphan")
    appointments = db.relationship('Appointment', backref='user', cascade="all, delete-orphan")

    def set_password(self, password):
        self.u_password = generate_password_hash(password)

    def check_password(self, password):
        return check_password_hash(self.u_password, password)

    def get_id(self):
        return str(self.user_id)


class Vehicle(db.Model):
    __tablename__ = 'vehicle'

    vehicle_id = db.Column(db.Integer, primary_key=True)
    plate_number = db.Column(db.String(20), unique=True, nullable=False)
    brand = db.Column(db.String(50), nullable=False)
    model = db.Column(db.String(50), nullable=False)
    model_year = db.Column(db.Integer, nullable=False)
    fuel_type = db.Column(db.String(30), nullable=False)
    km = db.Column(db.Integer, nullable=False)
    ownership_count = db.Column(db.Integer, nullable=False)
    created_at = db.Column(db.DateTime, default=datetime.utcnow)
    updated_at = db.Column(db.DateTime, default=datetime.utcnow)

    user_id = db.Column(db.Integer, db.ForeignKey('users.user_id', ondelete='CASCADE'), nullable=False)
    appointments = db.relationship('Appointment', backref='vehicle', cascade="all, delete-orphan")


class City(db.Model):
    __tablename__ = 'city'

    city_id = db.Column(db.Integer, primary_key=True)
    city_name = db.Column(db.String(25), nullable=False)

    dealerships = db.relationship('Dealership', backref='city', cascade="all, delete-orphan")


class Dealership(db.Model):
    __tablename__ = 'dealership'

    dealership_id = db.Column(db.Integer, primary_key=True)
    d_name = db.Column(db.String(100), nullable=False)
    address = db.Column(db.Text, nullable=False)
    d_phone = db.Column(db.String(15), nullable=False)
    latitude = db.Column(db.Float)
    longitude = db.Column(db.Float)

    city_id = db.Column(db.Integer, db.ForeignKey('city.city_id', ondelete='CASCADE'), nullable=False)
    appointments = db.relationship('Appointment', backref='dealership', cascade="all, delete-orphan")
    employees = db.relationship('Employee', backref='dealership')


class MaintenanceType(db.Model):
    __tablename__ = 'maintenance_type'

    type_id = db.Column(db.Integer, primary_key=True)
    type_name = db.Column(db.String(50), nullable=False)

    appointments = db.relationship('Appointment', backref='maintenance_type', cascade="all, delete-orphan")


class Appointment(db.Model):
    __tablename__ = 'appointment'

    appointment_id = db.Column(db.Integer, primary_key=True)
    a_date = db.Column(db.Date, nullable=False)
    a_time = db.Column(db.Time, nullable=False)
    status = db.Column(db.String(20), nullable=False)
    price = db.Column(db.Numeric(10, 2), nullable=False)

    user_id = db.Column(db.Integer, db.ForeignKey('users.user_id', ondelete='CASCADE'), nullable=False)
    vehicle_id = db.Column(db.Integer, db.ForeignKey('vehicle.vehicle_id', ondelete='CASCADE'), nullable=False)
    dealership_id = db.Column(db.Integer, db.ForeignKey('dealership.dealership_id', ondelete='CASCADE'), nullable=False)
    type_id = db.Column(db.Integer, db.ForeignKey('maintenance_type.type_id', ondelete='CASCADE'), nullable=False)


class Employee(UserMixin, db.Model):
    __tablename__ = 'employee'

    employee_id = db.Column(db.Integer, primary_key=True)
    e_fname = db.Column(db.String(50), nullable=False)
    e_lname = db.Column(db.String(50), nullable=False)
    e_phone = db.Column(db.String(15), nullable=False)
    e_email = db.Column(db.String(100), nullable=False)
    e_role = db.Column(db.String(20), nullable=False)
    hire_date = db.Column(db.Date, nullable=False)

    dealership_id = db.Column(db.Integer, db.ForeignKey('dealership.dealership_id', ondelete='SET NULL'))
    
    def get_id(self):
        return f"e{self.employee_id}"


class EmployeeSchedule(db.Model):
    __tablename__ = 'employee_schedule'

    schedule_id = db.Column(db.Integer, primary_key=True)
    work_date = db.Column(db.Date, nullable=False)
    start_time = db.Column(db.Time, nullable=False)
    end_time = db.Column(db.Time, nullable=False)

    employee_id = db.Column(db.Integer, db.ForeignKey('employee.employee_id', ondelete='CASCADE'))
    appointment_id = db.Column(db.Integer, db.ForeignKey('appointment.appointment_id', ondelete='SET NULL'))
    appointment = db.relationship('Appointment', backref='schedules')
