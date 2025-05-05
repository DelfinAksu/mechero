from flask import Blueprint, render_template, request
from app.models import Dealership, City
from app import db

bp = Blueprint('dealership', __name__, url_prefix='/dealerships')

@bp.route('/')
def list_dealerships():
    city_id = request.args.get('city_id')  # GET parametresiyle gelen city_id alınır
    cities = City.query.all()  # dropdown için tüm şehirler alınır

    if city_id:
        dealerships = Dealership.query.filter_by(city_id=city_id).all()
    else:
        dealerships = Dealership.query.all()

    return render_template(
        'dealership/list.html',
        dealerships=dealerships,
        cities=cities,
        selected_city_id=city_id  # sayfada hangi şehir seçilmişti hatırlamak için
    )
