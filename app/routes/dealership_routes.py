from flask import Blueprint, render_template
from app.models import Dealership
from app import db

bp = Blueprint('dealership', __name__, url_prefix='/dealerships')

@bp.route('/')
def list_dealerships():
    dealerships = Dealership.query.all()
    return render_template('dealership/list.html', dealerships=dealerships)
