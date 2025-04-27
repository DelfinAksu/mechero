from flask import Blueprint, render_template

bp = Blueprint('guest', __name__)

@bp.route('/')
@bp.route('/home')
def home_page():
    return render_template('guest/index.html')

@bp.route('/about')
def about_page():
    return render_template('guest/about.html')

@bp.route('/register')
def register_page():
    return render_template('guest/register.html')

@bp.route('/login')
def login_page():
    return render_template('guest/login.html')
