from flask import Blueprint, render_template, redirect, url_for, flash, request
from app.forms import RegisterForm, LoginForm
from app.models import User, Dealership, City, Employee
from app import db
from flask_login import login_user, logout_user, current_user, login_required

bp = Blueprint('guest', __name__)

# 👤 Kullanıcı Kayıt
@bp.route('/register', methods=['GET', 'POST'])
def register_page():
    form = RegisterForm()
    if form.validate_on_submit():
        existing_user = User.query.filter_by(u_mail=form.email.data).first()
        if existing_user:
            flash("Bu e-posta adresi zaten kayıtlı!", "danger")
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
            flash("Kayıt başarılı! Giriş yapabilirsiniz.", "success")
            return redirect(url_for('guest.login_page'))
        except Exception as e:
            db.session.rollback()
            flash(f"Kayıt sırasında bir hata oluştu: {e}", "danger")

    return render_template('guest/register.html', form=form)

@bp.route('/login', methods=['GET', 'POST'])
def login_page():
    form = LoginForm()

    if form.validate_on_submit():
        email = form.email.data
        password = form.password.data

        # Eğer çalışan girişi ise
        if email.endswith('@mechero.com'):
            try:
                emp_id = int(email.split('@')[0])
                employee = Employee.query.filter_by(employee_id=emp_id).first()
                if employee and password == str(employee.employee_id):
                    login_user(employee)
                    flash("Çalışan girişi başarılı!", "success")
                    return redirect(url_for('employee.dashboard'))
                else:
                    flash("Geçersiz çalışan bilgileri", "danger")
            except:
                flash("Hatalı çalışan e-posta formatı", "danger")
            return redirect(url_for('guest.login_page'))

        # Eğer normal kullanıcı ise
        user = User.query.filter_by(u_mail=email).first()
        if user and user.check_password(password):
            login_user(user)
            flash("Giriş başarılı!", "success")
            return redirect(url_for('user.dashboard'))
        else:
            flash("Geçersiz e-posta veya şifre", "danger")
            return redirect(url_for('guest.login_page'))

    else:
        print("🛑 FORM HATALARI:", form.errors)

    return render_template('guest/login.html', form=form)

# 🚪 Çıkış
@bp.route('/logout')
@login_required
def logout_page():
    logout_user()
    flash("Başarıyla çıkış yapıldı.", "info")
    return redirect(url_for('guest.login_page'))

# 🚗 Bayi Listeleme (Haritalı)
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

@bp.route('/about')
def about_page():
    return render_template('guest/about.html')

@bp.route('/')
def index_page():
    return render_template('guest/index.html')