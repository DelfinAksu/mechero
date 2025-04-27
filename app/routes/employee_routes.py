from flask import Blueprint, render_template

bp = Blueprint('employee', __name__)

@bp.route('/dashboard')
def dashboard():
    return render_template('employee/dashboard.html')
