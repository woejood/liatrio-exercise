from datetime import datetime
import json
from flask import Flask, render_template, jsonify

app = Flask(__name__)

@app.route('/')
def index():
    message = "Automate all the things!"
    now = datetime.now()
    timestamp = datetime.timestamp(now)
    response = jsonify({'message':message,'timestamp':timestamp})
    return response.content_type("application/json")

if __name__ == '__main__':
    app.run(debug=False,host='0.0.0.0')