from flask import Flask, request, jsonify
import requests
import json



app = Flask(__name__)


ARLIAI_API_KEY = "dec15259-a611-485c-871f-e2ee49a280da"

def prompt(data: dict):
    url = "https://api.arliai.com/v1/chat/completions"
    if not isinstance(data, dict):
        raise TypeError("Expected 'data' to be a dictionary")
    else: 
        payload = json.dumps({
        "model": "Mistral-Nemo-12B-Instruct-2407",
        "messages": [
            {"role": "system", "content": "You are a helpful assistant."},
            {"role": "user", "content": "Hello!"},
            {"role": "assistant", "content": "Hi!, how can I help you today?"},
            {"role": "user", "content": "Say hello!"}
        ],
        "repetition_penalty": 1.1,
        "temperature": 0.7,
        "top_p": 0.9,
        "top_k": 40,
        "max_tokens": 1024,
        "stream": True
        })
        headers = {
        'Content-Type': 'application/json',
        'Authorization': f"Bearer {ARLIAI_API_KEY}"
        }

    response = requests.request("POST", url, headers=headers, data=payload)
    # Extract and return the reply from the assistant
    if response.status_code == 200:
        return response.headers.get('Content-Type')
    else: 
        return "failed"



@app.route('/api/data', methods=['GET'])
def get_data():
    return jsonify("template")

@app.route('/api/data', methods=['POST'])
def post_data():
    print("got request")
    data = request.json
    if data:
        # You can process the data here as needed
        print(prompt(data))
        
        return jsonify({"received": data}), 201  # Respond with the received data
    return jsonify({"error": "Invalid data"}), 400  # Bad request if data is not valid

if __name__ == '__main__':
    app.run(debug=True)
