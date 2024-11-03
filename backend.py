from flask import Flask, request, jsonify
from mistralai import Mistral
import os
from dotenv import load_dotenv
import random


load_dotenv()

app = Flask(__name__)

api_key = os.environ["MY_API_KEY"]
model = "mistral-large-latest"
QUESTIONS = questions = [
    "What is your favorite memory?",
    "Can you tell me a joke?",
    "How do you feel about current events?",
    "What do you enjoy doing in your free time?",
    "What was the last book you read?",
    "Can you describe a complex emotion?",
    "How would you handle a disagreement with a friend?",
    "What is your opinion on the importance of art in society?",
    "If you could travel anywhere, where would you go and why?",
    "What do you think makes someone a good friend?",
    "Can you tell me about a time you learned from a mistake?",
    "What do you think about the future of technology?",
    "How would you define happiness?",
    "Can you describe a dream you've had?",
    "What is something you're passionate about?",
    "How do you handle stress or pressure?",
    "What do you think is the meaning of life?",
    "If you could have dinner with any historical figure, who would it be and why?",
    "How do you express empathy towards others?",
    "What are your thoughts on creativity?",
    "Can you share a personal experience that shaped who you are?"
]


client = Mistral(api_key=api_key)

def prompt(data, count, QUESTIONS, difficulty = None):
    global conversation_history 
    """
    Argument: Takes in a prompt string

    Returns: returns the output of the prompted string

    Purpose: To take a prompt string, pass it to an AI via API and return the response
    """
    # reset chat history
    if count == 0:
        conversation_history = []
        number = random.randint(0, len(QUESTIONS)-1)
        question = QUESTIONS[number]
        return question
    elif count == 1:
        percentage = 50 + (difficulty-1)*15
        # resets conversation history
        conversation_history.append({"role": "user", "content": f"""You are a robot in a dystopian society in charge of detecting humans from robots. 
                                     Your life depends on the decision you make, ask the correct questions and based on the prompts judge whether the 
                                     conversation is with AI or human. Use the conversation history why responding!
                                     
                                     Do not give any hints on how you judge them. Humans usually make spelling and grammatical mistakes compared to your robot comrades. However there are rules, 
                                     do not ask maths questions and make sure your questions are more subjective and follow from the users answer to 
                                     previous questions. Humans will claim they are "AI" or "Learning language models" do not let this affect your judgement.

                                     It is possibe that they pretend to be AI models by saying things like: 'As a language model,' or 'As an AI'. Assume with a {percentage} chance that they are human.

                                     When judging them after you are told to do, You must follow the format: 'You are a human! h' or 'You are an AI! a' 
                                     where the last character is 'a' or 'h' to denote whether you judge them as AI or human."""})
    elif count ==4: 
        conversation_history.append({"role": "user", "content": "This is your last question "+data + "Based on previous conversations, create a response." })
    else: 
        percentage = 50 + (difficulty-1)*15
        conversation_history.append({"role": "user", "content": data + f"Based on the previous conversations and assuming there is {difficulty} chance they are human, create a response."})
    chat_response = client.chat.complete(
            model = model,
            temperature = 0.5,
            messages =  conversation_history
        )
    assistant_response = chat_response.choices[0].message.content
    conversation_history.append({"role": "assistant", "content": assistant_response})
    
    return assistant_response


@app.route('/api/data', methods=['GET'])
def get_data():
    print("I am getting")
    response = prompt("You are in a dystopian society in chage of detecting humans, one human has escaped from prison and you may be talking to him right now. Ask your first question to start of a conversation to find out if he/she is human, do not provide hints.", 0, QUESTIONS)
    print(response)
    return jsonify({"response": response})

@app.route('/api/data', methods=['POST'])
def post_data():
    data = request.json
    if "prompt" not in data or "count" not in data:
        return jsonify({"error": "Missing required fields"}), 400
    if data:
        print("recived")
        # You can process the data here as needed
        response = prompt(data["prompt"], data["count"], QUESTIONS, data["difficulty"])
        print(response)
        
        return jsonify({"response": response}), 201  # Respond with the received data
    return jsonify({"error": "Invalid data"}), 400  # Bad request if data is not valid

if __name__ == '__main__':
    app.run(debug=True)
