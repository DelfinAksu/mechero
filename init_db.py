from app import create_app, db
from app.models import City, Dealership

app = create_app()

with app.app_context():
    # Tablo oluşturma ve silme işlemleri YOK ❌
    # Sadece veri ekleme ✅

    # Eğer daha önce şehirler eklendiyse tekrar eklenmesin
    if City.query.count() == 0:
        cities = [
            City(city_id=1, city_name='İstanbul'),
            City(city_id=2, city_name='Ankara'),
            City(city_id=3, city_name='İzmir'),
            City(city_id=4, city_name='Bursa'),
            City(city_id=5, city_name='Antalya'),
            City(city_id=6, city_name='Konya'),
            City(city_id=7, city_name='Gaziantep'),
        ]
        db.session.bulk_save_objects(cities)
        db.session.commit()

    # Bayileri sadece ilk kez ekle
    if Dealership.query.count() == 0:
        dealerships = [
            Dealership(d_name='CarPoint İST1', city_id=1, address='Bağdat Cad. No:123', d_phone='02121234567', latitude=40.983, longitude=29.069),
            Dealership(d_name='FixMaster İST2', city_id=1, address='Barbaros Bulv. No:55', d_phone='02127654321', latitude=41.043, longitude=29.009),
            Dealership(d_name='AutoFix ANK1', city_id=2, address='Atatürk Blv. No:33', d_phone='03121234567', latitude=39.93, longitude=32.85),
            Dealership(d_name='CarMaster İZM1', city_id=3, address='Kordon Boyu Cad. No:99', d_phone='02321234567', latitude=38.42, longitude=27.13),
            Dealership(d_name='FixPro BUR1', city_id=4, address='Cumhuriyet Cad. No:45', d_phone='02242124567', latitude=40.18, longitude=29.06),
            Dealership(d_name='CarStop ANT1', city_id=5, address='Konyaaltı Cad. No:76', d_phone='02421234567', latitude=36.89, longitude=30.7),
            Dealership(d_name='AutoTech KON1', city_id=6, address='Mevlana Cad. No:11', d_phone='03322124567', latitude=37.87, longitude=32.48),
            Dealership(d_name='FixGarage GAZ1', city_id=7, address='İpekyolu Cad. No:88', d_phone='03422124567', latitude=37.07, longitude=37.38),
        ]
        db.session.bulk_save_objects(dealerships)
        db.session.commit()

    print("✅ PostgreSQL için şehirler ve bayiler eklendi!")
