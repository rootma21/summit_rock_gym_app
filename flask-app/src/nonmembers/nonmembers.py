from flask import Blueprint, request, jsonify, make_response
import json
from src import db


nonmembers = Blueprint('nonmembers', __name__)


# Get all the products from the database
@nonmembers.route('/nonmembers', methods=['GET'])
def get_products():
    return "hello nonmember"

# Get all the products from the database


@nonmembers.route('/nonmembers/submit_waiver', methods=['POST'])
def submit_waiver():
    """# create a cursor
    cursor = db.get_db().cursor()
    query = f'INSERT INTO student values ({request.form["nuid"]})'
    cursor.execute(query)
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response
    # execute an INSERT query"""

    return "hello nonmember"
