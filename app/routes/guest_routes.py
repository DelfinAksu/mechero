from flask import Blueprint, render_template, redirect, url_for, flash
from app.forms import RegisterForm , LoginForm
from app.models import User
from app import db
from flask_login import login_user, logout_user, current_user, login_required

bp = Blueprint('guest', __name__)

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


@bp.route('/login', methods=['GET', 'POST'])
def login_page():
    form = LoginForm()
    if form.validate_on_submit():
        user = User.query.filter_by(email=form.email.data).first()
        if user and user.check_password(form.password.data):
            login_user(user)
            flash("Başarıyla giriş yaptınız!", "success")
            return redirect(url_for('user.dashboard'))  # Kullanıcı paneline yönlendir
        else:
            flash("Geçersiz e-posta veya şifre", "danger")
            return redirect(url_for('guest.login_page'))

    return render_template('guest/login.html', form=form)

@bp.route('/logout')
@login_required
def logout_page():
    logout_user()
    flash("Başarıyla çıkış yapıldı.", "info")
    return redirect(url_for('guest.login_page'))
