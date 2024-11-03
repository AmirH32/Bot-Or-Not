# Stealth Game with Reverse Turing Test

## Overview

Welcome to the **Stealth Game**! In this interactive game, players must navigate through a world populated by AI bots. The goal is to remain undetected while completing objectives. If a bot spots you, you will have to engage in a Reverse Turing Test to prove your humanity. This game combines stealth mechanics with AI interaction, creating a unique gameplay experience.

## Technologies Used

This project is built using the following libraries:

- **Flask**: A lightweight WSGI web application framework for Python, used to create the server-side application.
- **Mistral**: An AI model used for generating responses during the Reverse Turing Test.
- **dotenv**: A library that loads environment variables from a `.env` file, ensuring secure management of sensitive information such as API keys.
- **random**: A built-in Python library used to introduce randomness into the game mechanics, such as bot behaviors and prompts.

## Features

- Stealth gameplay mechanics where players must avoid detection by AI bots.
- Engage in a Reverse Turing Test when spotted by a bot, answering questions to prove your humanity.
- Dynamic interaction with AI, making each encounter unique.
- Simple and clean interface powered by Flask.

## Installation

### Prerequisites

Ensure you have Python installed on your system. This project uses Python 3.6 or higher.

### Step-by-Step Guide

1. **Clone the Repository and move working directory**:

   ```bash
   git clone https://github.com/yourusername/stealth-game.git
   cd stealth-game

2. **Install Required Packages**

   Use pip to install the necessary libraries:
   ```pip install Flask python-dotenv mistralai```
3. **Set Up Environment Variables:**

   Create a `.env` file in the root of your project directory and add your API key:
   ```
   MY_API_KEY=your_api_key_here
   ```

4. **Download and install Godot4**
   Download and install godot 4 from:
   https://godotengine.org/download/windows/ (for windows)
   https://godotengine.org/download/linux/ (for linux)

5. **Open the project in Godot4**
   Use Godot4 to open the project and run it using the play button on the top right


7. **Run the Backend:**
   ```
   python backend.py
   python3 backend.py
   ```

## Gameplay Instructions

   Navigate through the Game World: Use your keyboard (W,A,S,D or arrow keys) to move around the game environment.
   Avoid Detection: Stay out of sight from the AI bots. If a bot spots you, prepare for a Reverse Turing Test.
   Reverse Turing Test: Answer the AI's questions to decieve it and pretent you are AI. Your responses will be evaluated based on previous conversations.
   Complete Objectives: Your main goal is to complete the game objectives without being detected.

## Feature Requests
   Have an idea for a new feature? We’d love to hear it! Please submit a feature request with a clear description of what you’d like to see.

## Contributing

   If you encounter any issues while playing or testing the game, please open an issue detailing the problem.

   Fork the repository and create a new branch for your feature or bug fix.
   Make your changes and ensure your code adheres to the existing style and conventions.
   Write tests for any new functionality you add (we never included tests, work in progress)
   Submit a pull request with a clear description of your changes.
   You can also help with documentation.

## License

   This project is licensed under the MIT License - see the LICENSE file for details.
   Contact
   
   For any questions or feedback, please reach out to us.
