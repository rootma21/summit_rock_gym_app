from flask import Blueprint, request, jsonify, make_response
import json
from src import db


nonmembers = Blueprint('nonmembers', __name__)


# Get all the products from the database
@nonmembers.route('/nonmembers', methods=['GET'])
def get_products():
    return "hello nonmember"
