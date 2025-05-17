from flask import Blueprint, render_template, redirect, url_for, flash, request
from app.forms import RegisterForm, LoginForm
from app.models import User, Dealership, City, Employee
from app import db
from flask_login import login_user, logout_user, current_user, login_required

bp = Blueprint('guest', __name__)

# Register Part
@bp.route('/register', methods=['GET', 'POST'])
def register_page():
    form = RegisterForm()
    if form.validate_on_submit():
        existing_user = User.query.filter_by(u_mail=form.email.data).first()
        if existing_user:
            flash("This email address is already registered!", "danger")
            return redirect(url_for('guest.register_page'))

        try:
            user = User(
                u_fname=form.fname.data,
                u_lname=form.lname.data,
                u_phone=form.phone.data,
                u_mail=form.email.data
            )
            user.set_password(form.password.data)
            db.session.add(user)
            db.session.commit()
            flash("Registration successful! You can now log in.", "success")
            return redirect(url_for('guest.login_page'))
        except Exception as e:
            db.session.rollback()
            flash(f"An error occurred during registration: {e}", "danger")

    return render_template('guest/register.html', form=form)

#Login Part
@bp.route('/login', methods=['GET', 'POST'])
def login_page():
    form = LoginForm()

    if form.validate_on_submit():
        email = form.email.data
        password = form.password.data

        # Employee Login
        if email.endswith('@mechero.com'):
            try:
                emp_id = int(email.split('@')[0])
                employee = Employee.query.filter_by(employee_id=emp_id).first()
                if employee and password == str(employee.employee_id):
                    login_user(employee)
                    flash("Employee login successful!", "success")
                    return redirect(url_for('employee.dashboard'))
                else:
                    flash("Invalid employee informations.", "danger")
            except:
                flash("Invalid employee email format.", "danger")
            return redirect(url_for('guest.login_page'))

        # User Login
        user = User.query.filter_by(u_mail=email).first()
        if user and user.check_password(password):
            login_user(user)
            # Admin Login
            if user.u_mail == 'admin@admin.com':
                flash("Admin login successful!", "success")
                return redirect(url_for('admin.dashboard'))
            else:
                flash("User login successful!", "success")
                return redirect(url_for('user.dashboard'))
        else:
            flash("Invalid e-mail or password", "danger")
            return redirect(url_for('guest.login_page'))

    else:
        print("FORM ERRORS:", form.errors)

    return render_template('guest/login.html', form=form)

# Logout Part
@bp.route('/logout', methods=['GET', 'POST'])
@login_required
def logout_page():
    logout_user()
    flash("Successfully logged out.", "info")
    return redirect(url_for('guest.login_page'))

# Dealerships List Part
@bp.route('/dealerships/')
def list_dealerships():
    city_id = request.args.get('city_id')
    cities = City.query.all()

    if city_id:
        dealerships = Dealership.query.filter_by(city_id=city_id).all()
    else:
        dealerships = Dealership.query.all()

    dealerships_json = [
        {
            'id': d.dealership_id,
            'name': d.d_name,
            'address' : d.address,
            'phone' : d.d_phone,
            'latitude': d.latitude,
            'longitude': d.longitude
        }
        for d in dealerships
    ]

    return render_template(
        'guest/dealership.html',
        cities=cities,
        dealerships=dealerships,
        dealerships_json=dealerships_json,
        selected_city_id=city_id
    )

#About us Part
@bp.route('/about')
def about_page():
    return render_template('guest/about.html')

#Index Part
@bp.route('/')
def index_page():
    return render_template('guest/index.html')