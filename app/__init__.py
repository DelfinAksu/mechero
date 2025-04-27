from flask import Flask
from config import Config

def create_app():
    app = Flask(__name__)
    app.config.from_object(Config)

    from app.routes.guest_routes import bp as guest_bp
    app.register_blueprint(guest_bp)

    from app.routes.user_routes import bp as user_bp
    app.register_blueprint(user_bp, url_prefix='/user')

    from app.routes.employee_routes import bp as employee_bp
    app.register_blueprint(employee_bp, url_prefix='/employee')

    from app.routes.admin_routes import bp as admin_bp
    app.register_blueprint(admin_bp, url_prefix='/admin')

    return app
