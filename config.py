import os # os: (operating system)

basedir = os.path.abspath(os.path.dirname(__file__))

class Config:
    SECRET_KEY = 'dev-key' # key for security, 'dev-key' used only for development
    SQLALCHEMY_DATABASE_URI = 'sqlite:///' + os.path.join(basedir, 'site.db') # defined the db path that will be used
    SQLALCHEMY_TRACK_MODIFICATIONS = False # disable tracking of db changes
