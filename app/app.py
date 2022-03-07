import calendar
import time
import json
from flask import Flask, render_template, jsonify

app = Flask(__name__)

@app.route('/')
def index():
    message = "Automate all the things!"
    gmt = time.gmtime()
    timestamp = calendar.timegm(gmt)
    response = jsonify({'message':message,'timestamp':timestamp})
    return response

if __name__ == '__main__':
    app.run(debug=False,host='0.0.0.0')