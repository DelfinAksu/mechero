from app import create_app, db
from app.models import City, Dealership

app = create_app()

with app.app_context():
    db.drop_all()         # ❌ Mevcut tüm tabloları siler
    db.create_all()       # ✅ Yeni yapıya göre tüm tabloları oluşturur

    # Şehirleri ekleyelim
    cities = [
        City(name='İstanbul'),
        City(name='Ankara'),
        City(name='İzmir'),
        City(name='Bursa'),
        City(name='Antalya'),
        City(name='Konya'),
        City(name='Gaziantep'),
    ]
    db.session.bulk_save_objects(cities)
    db.session.commit()

    # Şehirleri veritabanından çek
    ist = City.query.filter_by(name='İstanbul').first()
    ank = City.query.filter_by(name='Ankara').first()
    izm = City.query.filter_by(name='İzmir').first()
    bur = City.query.filter_by(name='Bursa').first()
    ant = City.query.filter_by(name='Antalya').first()
    kon = City.query.filter_by(name='Konya').first()
    gaz = City.query.filter_by(name='Gaziantep').first()

    # Bayiler
    dealerships = [
        Dealership(name='CarPoint İST1', city_id=ist.id, street='Bağdat Cad.', number='123', latitude=40.983, longitude=29.069),
        Dealership(name='FixMaster İST2', city_id=ist.id, street='Barbaros Bulv.', number='55', latitude=41.043, longitude=29.009),
        Dealership(name='AutoFix ANK1', city_id=ank.id, street='Atatürk Blv.', number='33', latitude=39.93, longitude=32.85),
        Dealership(name='CarMaster İZM1', city_id=izm.id, street='Kordon Boyu Cad.', number='99', latitude=38.42, longitude=27.13),
        Dealership(name='FixPro BUR1', city_id=bur.id, street='Cumhuriyet Cad.', number='45', latitude=40.18, longitude=29.06),
        Dealership(name='CarStop ANT1', city_id=ant.id, street='Konyaaltı Cad.', number='76', latitude=36.89, longitude=30.7),
        Dealership(name='AutoTech KON1', city_id=kon.id, street='Mevlana Cad.', number='11', latitude=37.87, longitude=32.48),
        Dealership(name='FixGarage GAZ1', city_id=gaz.id, street='İpekyolu Cad.', number='88', latitude=37.07, longitude=37.38),
    ]
    db.session.bulk_save_objects(dealerships)
    db.session.commit()

    print("✅ Genişletilmiş veritabanı oluşturuldu!")
