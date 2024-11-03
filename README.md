Overview

Welcome to the Stealth Game! In this interactive game, players must navigate through a world populated by AI bots. The goal is to remain undetected while completing objectives. If a bot spots you, you will have to engage in a Reverse Turing Test to prove your humanity. This game combines stealth mechanics with AI interaction, creating a unique gameplay experience.
Technologies Used

This project is built using the following libraries:

    Flask: A lightweight WSGI web application framework for Python, used to create the server-side application.
    Mistral: An AI model used for generating responses during the Reverse Turing Test.
    dotenv: A library that loads environment variables from a .env file, ensuring secure management of sensitive information such as API keys.
    random: A built-in Python library used to introduce randomness into the game mechanics, such as bot behaviors and prompts.

Features

    Stealth gameplay mechanics where players must avoid detection by AI bots.
    Engage in a Reverse Turing Test when spotted by a bot, answering questions to prove your humanity.
    Dynamic interaction with AI, making each encounter unique.
    Simple and clean interface powered by Flask.

Installation
Prerequisites

Ensure you have Python installed on your system. This project uses Python 3.6 or higher.
Step-by-Step Guide

    Clone the Repository:

    bash

git clone https://github.com/yourusername/stealth-game.git
cd stealth-game

Install Required Packages:

Use pip to install the necessary libraries:

bash

`pip install Flask python-dotenv mistralai`

Set Up Environment Variables:

Create a .env file in the root of your project directory and add your API key:

makefile

MY_API_KEY=your_api_key_here

Run the Application:

Start the Flask application:

bash

    python app.py

    Your server will run on http://127.0.0.1:5000.

Gameplay Instructions

    Navigate through the Game World: Use your keyboard or mouse to move around the game environment.
    Avoid Detection: Stay out of sight from the AI bots. If a bot spots you, prepare for a Reverse Turing Test.
    Reverse Turing Test: Answer the AI's questions to prove that you are human. Your responses will be evaluated based on previous conversations.
    Complete Objectives: Your main goal is to complete the game objectives without being detected.

Contributing

Contributions are welcome! If you want to improve the game or fix bugs, feel free to create a pull request. Please ensure to follow the coding conventions used in the project.
License

This project is licensed under the MIT License - see the LICENSE file for details.
Contact


Thank you for playing! Enjoy your stealthy adventure!
