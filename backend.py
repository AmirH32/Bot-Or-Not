from flask import Flask, request, jsonify
from mistralai import Mistral
import os
from dotenv import load_dotenv


app = Flask(__name__)

api_key = os.environ["MY_API_KEY"]
model = "mistral-large-latest"

client = Mistral(api_key=api_key)

def prompt(data):
    """
    Argument: Takes in a prompt string

    Returns: returns the output of the prompted string

    Purpose: To take a prompt string, pass it to an AI via API and return the response
    """

    chat_response = client.chat.complete(
            model = model,
            messages = [
                {
                    "role": "user",
                    "content": data,
                },
            ]
        )
    return chat_response.choices[0].message.content



@app.route('/api/data', methods=['GET'])
def get_data():
    return jsonify("template")

@app.route('/api/data', methods=['POST'])
def post_data():
    data = request.json
    if data:
        # You can process the data here as needed
        response = prompt(data["prompt"])
        
        return jsonify({"response": response}), 201  # Respond with the received data
    return jsonify({"error": "Invalid data"}), 400  # Bad request if data is not valid

if __name__ == '__main__':
    app.run(debug=True)
