from flask import Flask, request, jsonify
from mistralai import Mistral
import os
from dotenv import load_dotenv

load_dotenv()


app = Flask(__name__)

api_key = os.environ["MY_API_KEY"]
model = "mistral-large-latest"

client = Mistral(api_key=api_key)

def prompt(data, count):
    global conversation_history 
    """
    Argument: Takes in a prompt string

    Returns: returns the output of the prompted string

    Purpose: To take a prompt string, pass it to an AI via API and return the response
    """
    # reset chat history
    if count == 0:
        conversation_history = []
        conversation_history.append({"role": "user", "content": "You are a robot in a dystopian society in charge of detecting humans from robots. Your life depends on the decision you make, ask the correct questions and based on the prompts judge whether the conversation is with AI or humans. Do not give any hints on how you judge them."})
    conversation_history.append({"role": "user", "content": data + "Based on the previous conversations, create a response?"})
    chat_response = client.chat.complete(
            model = model,
            messages =  conversation_history
        )
    assistant_response = chat_response.choices[0].message.content
    conversation_history.append({"role": "assistant", "content": assistant_response})
    
    return assistant_response


@app.route('/api/data', methods=['GET'])
def get_data():
    return jsonify("template")

@app.route('/api/data', methods=['POST'])
def post_data():
    data = request.json
    if data:
        print("recived")
        # You can process the data here as needed
        response = prompt(data["prompt"], data["count"])
        print(response)
        
        return jsonify({"response": response}), 201  # Respond with the received data
    return jsonify({"error": "Invalid data"}), 400  # Bad request if data is not valid

if __name__ == '__main__':
    app.run(debug=True)
