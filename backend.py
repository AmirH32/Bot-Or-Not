from flask import Flask, request, jsonify
from openai import OpenAI



client = OpenAI(
    api_key = ""
)

app = Flask(__name__)

def prompt(data: dict):
    messages = ""
    if not isinstance(data, dict):
        raise TypeError("Expected 'data' to be a dictionary")
    else: 
        prompt_text = data["prompt"]
        chat_completion = client.chat.completions.create(
        messages =[
            {
                "role": "user",
                "content": "Say this is a test",
            }
        ],
        model="gpt-3.5-turbo",
        )
    # Extract and return the reply from the assistant
    return messages



@app.route('/api/data', methods=['GET'])
def get_data():
    return jsonify("template")

@app.route('/api/data', methods=['POST'])
def post_data():
    data = request.json
    if data:
        # You can process the data here as needed
        print(prompt(data))
        
        return jsonify({"received": data}), 201  # Respond with the received data
    return jsonify({"error": "Invalid data"}), 400  # Bad request if data is not valid

if __name__ == '__main__':
    app.run(debug=True)
