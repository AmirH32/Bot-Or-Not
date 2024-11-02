from flask import Flask, request, jsonify

app = Flask(__name__)

# Sample data to respond to GET requests
sample_data = {
    "message": "Hello from Flask!"
}

@app.route('/api/data', methods=['GET'])
def get_data():
    return jsonify(sample_data)

@app.route('/api/data', methods=['POST'])
def post_data():
    data = request.json
    if data:
        # You can process the data here as needed
        return jsonify({"received": data}), 201  # Respond with the received data
    return jsonify({"error": "Invalid data"}), 400  # Bad request if data is not valid

if __name__ == '__main__':
    app.run(debug=True)
