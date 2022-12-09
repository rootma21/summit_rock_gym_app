from flask import Blueprint, request, jsonify, make_response
import json
from src import db


members = Blueprint('members', __name__)

# Get all the products from the database


@members.route('/members', methods=['GET'])
def get_members():

    # set cursor
    cursor = db.get_db().cursor()

    # query gets all the info from the members table
    cursor.execute('select * from members')

    # create json
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Get ALL teams info from the database


@members.route('/members/teams', methods=['GET'])
def get_teams():

    # create cursor
    cursor = db.get_db().cursor()

    # create query
    query = """select Experience_level, Current_capacity, Age_group, Days_of_week, 
                First_name, Last_name
                from teams join employees e on e.ID = teams.Coach_ID;"""

    # execute
    cursor.execute(query)

    # return data as a json
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response


@members.route('/members/team_options', methods=['GET'])
def get_team_options():

    # create cursor
    cursor = db.get_db().cursor()

    # create query to get all nonmembers
    query = """select Experience_level, ID
                from teams;"""

    # execute query
    cursor.execute(query)

    # return data as a json
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'

    return the_response

# Get one team's info from the database


@members.route('/members/teams/<id>', methods=['GET'])
def get_one_team_info(id):

    # create cursor
    cursor = db.get_db().cursor()

    # create query
    query = f"""select Experience_level, Current_capacity, Age_group, Days_of_week, First_name, Last_name
            from teams join employees e on e.ID = teams.Coach_ID
            where teams.ID = '{id}';"""

    # execute query
    cursor.execute(query)

    # return data as a json
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'

    return the_response
