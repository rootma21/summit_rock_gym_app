from flask import Blueprint, request, jsonify, make_response
import json
from src import db

from datetime import date

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

#Get the members formatted for the waivers table (just name and last check in)
@members.route('/members/waivers_table', methods=["GET"])
def get_members_waivers_table():
    query = "SELECT First_name, Last_name, ID, Last_check_in, Frozen FROM members"
    # set cursor
    cursor = db.get_db().cursor()
    # query gets all the info from the members table
    cursor.execute(query)

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
    print(json_data)
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

#Post the latest check in time for a member
@members.route('/members/check_in', methods=["POST"])
def check_in_member():
    cursor = db.get_db().cursor()
    row = json.loads(request.form["row"])
    id = row["ID"]
    query = "UPDATE members SET Last_check_in = '{0}' WHERE ID = {1}".format(
        date.today().strftime("%Y-%m-%d %X"),
        id
    )

    cursor.execute(query)

    db.get_db().commit()

    return "Success"

# Get one team's info from the database
@members.route('/members/teams/at_level', methods=['GET'])
def get_one_team_info():

    # create cursor
    cursor = db.get_db().cursor()

    level = request.form["exp"]

    # create query
    query = f"""select Experience_level, Current_capacity, Age_group, Days_of_week, First_name, Last_name
            from teams join employees e on e.ID = teams.Coach_ID
            where teams.Experience_level = '{level}';"""

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

#Get the experience levels of every team
@members.route('/members/teams/experience_levels', methods=["GET"])
def get_experience_levels():
    query = "SELECT DISTINCT Experience_level FROM teams;"
    # create cursor
    cursor = db.get_db().cursor()
    # execute query
    cursor.execute(query)

    # return data as a json
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        level = row[0]
        json_data.append({"label": level, "value": level})
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'

    return the_response

# create new nonmember when they submit a waiver
@members.route('/members/new_member', methods=['POST'])
def submit_waiver():

    # create a cursor
    cursor = db.get_db().cursor()

    # name
    fname = request.form['first']
    lname = request.form['last']
    mi = request.form['mi']

    # dob
    dob = request.form['dob']

    # address
    street = request.form['street']
    city = request.form['city']
    state = request.form['state']
    zip = request.form['zip']

    # email and phone
    email = request.form['email']
    phone = request.form['phone']

    minor_status = request.form["minor_status"]
    membership_type = request.form["membership_type"]
    frozen = 0
    payment_type = "D" #We didn't end up using this, so it doesn't matter

    # create query
    query1_waivers = f"""INSERT INTO waivers (Waiver_type_minor)
    values (\"{minor_status}\");"""
    #print(query1_waivers)

    # execute query
    cursor.execute(query1_waivers)

    # commit to db
    db.get_db().commit()
#lol
    # create query
    query2_members = f"""insert into members
                            (First_name,
                            Middle_initial,
                            Last_name,
                            Date_of_birth,
                            Street_address,
                            Zip,
                            State,
                            City,
                            Email,
                            Phone,
                            Waiver_ID,
                            Minor_status,
                            Membership_type,
                            Frozen,
                            Payment_type)
     values (\"{fname}\", \"{mi}\", \"{lname}\", \"{dob}\", \"{street}\", \"{zip}\",
     \"{state}\", \"{city}\", \"{email}\", \"{phone}\", (select last_insert_id()),
     \"{minor_status}\", \"{membership_type}\", \"{frozen}\", \"{payment_type}\");"""
    print(query2_members)

    # execute query
    cursor.execute(query2_members)

    # commit to db
    db.get_db().commit()

    return 'Success!'
