from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from config import Config
from flask_login import LoginManager

db = SQLAlchemy()
login_manager = LoginManager()


def create_app():
    app = Flask(__name__)
    app.config.from_object(Config)
    db.init_app(app)

    login_manager.init_app(app)
    login_manager.login_view = 'guest.login_page'
    login_manager.login_message_category = 'info'
    
    from app.routes.guest_routes import bp as guest_bp
    app.register_blueprint(guest_bp)

    from app.routes.user_routes import bp as user_bp
    app.register_blueprint(user_bp, url_prefix='/user')

    from app.routes.employee_routes import bp as employee_bp
    app.register_blueprint(employee_bp, url_prefix='/employee')

    from app.routes.admin_routes import bp as admin_bp
    app.register_blueprint(admin_bp, url_prefix='/admin')

    return app
