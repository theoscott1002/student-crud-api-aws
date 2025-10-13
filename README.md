Note: it must be in a virtual environment.
pip install Flask Flask-Migrate Flask-SQLAlchemy psycopg2-binary python-dotenv
$env:FLASK_APP="run.py"
flask db init
flask db migrate -m "Initial migration"
flask db upgrade
flask run
###------Containerization Overview--------#####
Created the dockerfile and the docker compose file to create the app and db containers respectively
Updated the make file to biuld image and run container
Updated the .env file to have environment variables like database URL or secret key.
----->Issues encountered: 1. Got an unhealthy image; had to add app.run(host="0.0.0.0", port=5000) to the run.py
2. Had issues connecting to the db(PostgreSQL service); Logged into the container bash while it was running and  Ran flask db init, flask db migrate -m "initial migration", and flask db upgrade to create the db table
----->How to start containers: docker start student-api  and docker start db
