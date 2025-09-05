import os
from flask import Flask, jsonify
from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate
from sqlalchemy.exc import SQLAlchemyError

# Define db and migrate globally
db = SQLAlchemy()
migrate = Migrate()

def create_app():
    app = Flask(__name__)

    # Load configuration from environment variables
    app.config['SQLALCHEMY_DATABASE_URI'] = os.getenv(
        'DATABASE_URL',
        'postgresql://user:password@db:5432/student_db'
    )
    app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
    app.config['DEBUG'] = os.getenv('FLASK_ENV') == 'development'

    # Initialize database and migrations
    db.init_app(app)
    migrate.init_app(app, db)

    # Import and register blueprints
    from app.routes import api
    app.register_blueprint(api)

    # Import models to ensure they're registered with SQLAlchemy
    from app import models

    # Global error handler for database errors
    @app.errorhandler(SQLAlchemyError)
    def handle_db_error(error):
        return jsonify({"error": "Database error occurred", "details": str(error)}), 500

    return app