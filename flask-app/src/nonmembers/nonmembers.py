from flask import Blueprint, request, jsonify, make_response, current_app
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
    # check
    current_app.logger.info(request.form)

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

    # waiver_type
    waiver_type = request.form['type']

    # create query
    query1_waivers = f"""INSERT INTO waivers (Waiver_type_minor)
    values (\"{waiver_type}\");"""
    print(query1_waivers)

    # execute query
    cursor.execute(query1_waivers)

    # commit to db
    db.get_db().commit()

    # create query
    query2_nonmembers = f"""insert into nonmembers 
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
                            Waiver_ID)
     values (\"{fname}\", \"{mi}\", \"{lname}\", \"{dob}\", \"{street}\", \"{zip}\",
     \"{state}\", \"{city}\", \"{email}\", \"{phone}\", (select last_insert_id()));"""
    print(query2_nonmembers)

    """row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response"""
    # execute query
    cursor.execute(query2_nonmembers)

    # commit to db
    db.get_db().commit()

    return 'Success!'
