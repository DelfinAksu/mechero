from flask import Blueprint, render_template

bp = Blueprint('admin', __name__)

@bp.route('/dashboard')
def dashboard():
    return render_template('admin/dashboard.html')

@bp.route('/add-employee')
def add_employee():
    return render_template('admin/add_employee.html')

@bp.route('/remove-employee')
def remove_employee():
    return render_template('admin/remove_employee.html')
