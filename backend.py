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
    print(count, data)
    # reset chat history
    if count == 0:
        # resets conversation history
        conversation_history = []
        conversation_history.append({"role": "user", "content": "You are a robot in a dystopian society in charge of detecting humans from robots. Your life depends on the decision you make, ask the correct questions and based on the prompts judge whether the conversation is with AI or human. Do not give any hints on how you judge them. Humans usually make spelling and grammatical mistakes compared to your robot comrades. However there are rules, do not ask maths questions and make sure your questions are more subjective and nuanced. When judging them after you are told to do so please follow the format: 'You are a human! h' or 'You are an AI! a' where the last character is 'a' or 'h' to denote whether you judge them as AI or human. Just think about you would respond to your questions and if they respond differently, it is most likely a human"})
    elif count ==3: 
        conversation_history.append({"role": "user", "content": "This is your last question "+data + "Based on previous conversations, create a response." })
    else: 
        conversation_history.append({"role": "user", "content": data + "Based on the previous conversations, create a response."})
    chat_response = client.chat.complete(
            model = model,
            messages =  conversation_history
        )
    assistant_response = chat_response.choices[0].message.content
    conversation_history.append({"role": "assistant", "content": assistant_response})
    
    return assistant_response


@app.route('/api/data', methods=['GET'])
def get_data():
    print("I am getting")
    response = prompt("You are in a dystopian society in chage of detecting humans, one human has escaped from prison and you may be talking to him right now. Ask your first question to start of a conversation to find out if he/she is human, do not provide hints.", 0)
    print(response)
    return jsonify({"response": response})

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
