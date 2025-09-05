from app import db  # Import db from app/__init__.py

class Student(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(50))
    age = db.Column(db.Integer)
    grade = db.Column(db.String(10))