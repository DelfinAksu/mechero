from flask import Blueprint, render_template, redirect, url_for, flash, request
from app.forms import RegisterForm, LoginForm
from app.models import User, Dealership, City
from app import db
from flask_login import login_user, logout_user, current_user, login_required

bp = Blueprint('guest', __name__)

# 👤 Kullanıcı Kayıt
@bp.route('/register', methods=['GET', 'POST'])
def register_page():
    form = RegisterForm()
    if form.validate_on_submit():
        existing_user = User.query.filter_by(email=form.email.data).first()
        if existing_user:
            flash("Bu e-posta adresi zaten kayıtlı!", "danger")
            return redirect(url_for('guest.register_page'))

        user = User(
            fname=form.fname.data,
            lname=form.lname.data,
            email=form.email.data
        )
        user.set_password(form.password.data)
        db.session.add(user)
        db.session.commit()
        flash("Kayıt başarılı! Giriş yapabilirsiniz.", "success")
        return redirect(url_for('guest.login_page'))

    return render_template('guest/register.html', form=form)

# 🔑 Giriş
@bp.route('/login', methods=['GET', 'POST'])
def login_page():
    form = LoginForm()
    if form.validate_on_submit():
        user = User.query.filter_by(email=form.email.data).first()
        if user and user.check_password(form.password.data):
            login_user(user)
            flash("Başarıyla giriş yaptınız!", "success")
            return redirect(url_for('user.dashboard'))
        else:
            flash("Geçersiz e-posta veya şifre", "danger")
            return redirect(url_for('guest.login_page'))

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
            'id': d.id,
            'name': d.name,
            'street': d.street,
            'number': d.number,
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