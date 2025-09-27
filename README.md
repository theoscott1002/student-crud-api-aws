Note: it must be in a virtual environment.
pip install Flask Flask-Migrate Flask-SQLAlchemy psycopg2-binary python-dotenv
$env:FLASK_APP="run.py"
flask db init
flask db migrate -m "Initial migration"
flask db upgrade
flask run
