from flask import Blueprint, request, jsonify
from app import db  # Import db from app/__init__.py

api = Blueprint('api', __name__, url_prefix='/api/v1')

@api.route('/students', methods=['POST'])
def add_student():
    from app.models import Student  # Import here to avoid circular imports
    data = request.json
    new_student = Student(
        name=data['name'],
        age=data['age'],
        grade=data['grade']
    )
    db.session.add(new_student)
    db.session.commit()
    return jsonify({"message": "Student added"}), 201

@api.route('/students', methods=['GET'])
def get_students():
    from app.models import Student  # Import here to avoid circular imports
    students = Student.query.all()
    return jsonify([
        {
            "id": s.id,
            "name": s.name,
            "age": s.age,
            "grade": s.grade
        }
        for s in students
    ])

@api.route('/students/<int:id>', methods=['GET'])
def get_student(id):
    from app.models import Student  # Import here to avoid circular imports
    student = Student.query.get_or_404(id)
    return jsonify({
        "id": student.id,
        "name": student.name,
        "age": student.age,
        "grade": student.grade
    })

@api.route('/students/<int:id>', methods=['PUT'])
def update_student(id):
    from app.models import Student  # Import here to avoid circular imports
    student = Student.query.get_or_404(id)
    data = request.json
    student.name = data['name']
    student.age = data['age']
    student.grade = data['grade']
    db.session.commit()
    return jsonify({"message": "Student updated"})

@api.route('/students/<int:id>', methods=['DELETE'])
def delete_student(id):
    from app.models import Student  # Import here to avoid circular imports
    student = Student.query.get_or_404(id)
    db.session.delete(student)
    db.session.commit()
    return jsonify({"message": "Student deleted"})

@api.route('/healthcheck', methods=['GET'])
def health_check():
    return jsonify({"status": "OK"}), 200