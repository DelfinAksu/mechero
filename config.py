import os

basedir = os.path.abspath(os.path.dirname(__file__))

class Config:
    SECRET_KEY = 'dev-key'  # sadece geliştirme için kullanılabilir bir key
    SQLALCHEMY_DATABASE_URI = 'postgresql://postgres:4rmSiRUv@localhost:5432/mechero'
    SQLALCHEMY_TRACK_MODIFICATIONS = False
