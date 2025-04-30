from flask import Blueprint, render_template, redirect, url_for, flash
from app.forms import RegisterForm
from app.models import User
from app import db

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
    return render_template('guest/login.html')
