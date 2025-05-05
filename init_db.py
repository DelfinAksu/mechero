from app import create_app, db
from app.models import City, Dealership

app = create_app()

with app.app_context():
    db.drop_all()
    db.create_all()

    # Şehirler
    istanbul = City(name='İstanbul')
    ankara = City(name='Ankara')
    adana = City(name='Adana')
    db.session.add_all([istanbul, ankara, adana])
    db.session.commit()

    # Bayiler
    dealerships = [
        Dealership(name='CarPoint İST1', street='Bağdat Caddesi', number='123', latitude=40.983, longitude=29.069, city_id=istanbul.id),
        Dealership(name='AutoFix İST2', street='Barbaros Bulvarı', number='55', latitude=41.043, longitude=29.009, city_id=istanbul.id),
        Dealership(name='FixMaster ANK1', street='Tunalı Hilmi Caddesi', number='21', latitude=39.917, longitude=32.862, city_id=ankara.id),
        Dealership(name='OtoAdana', street='Ali Bozdoğanoğlu Blv.', number='88', latitude=37.001, longitude=35.321, city_id=adana.id)
    ]

    db.session.add_all(dealerships)
    db.session.commit()

    print("✅ Şehirler ve bayiler başarıyla oluşturuldu!")
