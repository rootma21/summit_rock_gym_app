from flask import Blueprint, request, jsonify, make_response
import json
from src import db


employees = Blueprint('employees', __name__)

# Get all employee from the DB


@employees.route('/employees', methods=['GET'])
def get_employee():
    return "the employee"
