from app import create_app, db
from app.models import Dealership  # BAYİ modelin varsa bunu ekle

app = create_app()
with app.app_context():
    db.create_all()

    # Bayi verilerini ekle (sadece örnek)
    sample_dealerships = [
        Dealership(name='CarPoint İST1', city='İstanbul', district='Kadıköy', street='Bağdat Caddesi', number='123', latitude=40.983, longitude=29.069),
        Dealership(name='AutoFix İST2', city='İstanbul', district='Beşiktaş', street='Barbaros Bulvarı', number='55', latitude=41.043, longitude=29.009),
        Dealership(name='FixMaster İST3', city='İstanbul', district='Üsküdar', street='Selami Ali Caddesi', number='87', latitude=41.023, longitude=29.036),
        Dealership(name='CarPoint ANK1', city='Ankara', district='Çankaya', street='Tunalı Hilmi Caddesi', number='21', latitude=39.917, longitude=32.862),
        Dealership(name='AutoFix ANK2', city='Ankara', district='Keçiören', street='Yavuz Sultan Selim Caddesi', number='42', latitude=39.983, longitude=32.866)
    ]

    db.session.bulk_save_objects(sample_dealerships)
    db.session.commit()
    print("✅ Veritabanı ve bayi verileri oluşturuldu!")
