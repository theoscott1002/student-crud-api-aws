run:
	python run.py

install:
	pip install -r requirements.txt

migrate:
	flask db migrate -m "migration"

upgrade:
	flask db upgrade

test:
	pytest
