from functools import wraps
from flask import redirect, url_for, flash
from flask_login import current_user

def admin_required(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        if not current_user.is_authenticated or current_user.u_mail != 'admin@admin.com':
            flash("You do not have permission to access this page.", "danger")
            return redirect(url_for('guest.login_page'))
        return f(*args, **kwargs)
    return decorated_function