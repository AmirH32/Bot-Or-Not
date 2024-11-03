class_name Chat
extends Node2D


# Reference the TextEdit and Answer (input field) nodes
@onready var text_edit = $TextEdit       # Main TextEdit box
@onready var answer_input = $AnswerEdit      # Input field (e.g., LineEdit or another TextEdit)
@onready var http_request_node = $HTTPRequest # The HTTP Request node
var prompt_count: int = 0 # initialise prompt count
var parent_ai : AI_robot # The parent AI node
@onready var result_button = $ResultButton  # Adjust the path as necessary
var win # variable that holds if you have won or not
var difficulty : int

signal death # signals death
signal increment # signals increment

func create_post_data(prompt, prompt_count):
	var post_data = {
			"prompt": prompt, # prompt for AI
			"count": prompt_count  # You can increment this counter if needed
	}
	return post_data
	
# Function to handle input events
func _input(event):
	if event is InputEventKey and event.pressed and event.keycode == KEY_ENTER:
		_on_send_pressed()  # Call the send function

# On startup get the first question from AI
func _ready() -> void:
	 # Set the TextEdit to full screen size
	win = null # Win is automatically nothing when chat box is started
	result_button.visible = false # Hides the continue button
	
	### Anchors the text edit in the screen
	text_edit.anchor_left = 0
	text_edit.anchor_top = 0
	text_edit.anchor_right = 1
	text_edit.anchor_bottom = 1
	
	### Adds some UI information
	text_edit.text += "WOIP - AI bot might take a little delay to respond, it will interrogate you with 5 questions before deciding whether you are a human or a robot \n"
	# Gets the first question to showcase the user
	http_request_node.get_first_question()
	prompt_count += 1
	print("Number of prompts sent:", prompt_count)
	# Logs the number of prompts, increases counter so when it hits 5 it can make a decision
	
	
# Function called when the Send button is pressed
func _on_send_pressed():
	# Confirm the button is triggering this function
	print("Button pressed - Sending input text")
	
	# Verify if the text_edit and answer_input nodes are accessible
	if text_edit and answer_input:
		print("TextEdit and Answer nodes found - Adding input text")
		
		# Gets the user input from the answer_input node box
		var user_input = answer_input.text 
		
		# Append the text from the Answer input field to the TextEdit box
		text_edit.text += "User:" + user_input + "\n"
		
		
		### Handles POST and incrementing counter
		# Creates the post json 
		var post_data = create_post_data(user_input, prompt_count)
		
		# sends a http request
		http_request_node.send_post_request(post_data)
		
		prompt_count += 1
		print("Number of prompts sent:", prompt_count)
		
		# Reset the count every 5 prompts
		if prompt_count >= 5:
			# AI makes its decision
			post_data = create_post_data("You must now judge whether the person you have talked to is a human or a robot, your life depends on this decision (your answer must follow the format 'You are a human! h' or 'You are an AI! a' where the last character is 'a' or 'h' to denote whether you judge them as AI or human",prompt_count)
			# Sends post request to judge the player
			http_request_node.send_post_request(post_data)
			
			prompt_count += 1
		###
		
		
		# Clear the input field after sending the text
		answer_input.text = ""
	else:
		print("One or more nodes not found! Check the path.")
	answer_input.grab_focus()

func reset_prompt_count():
	### Purpose: Reset the prompt counter
	prompt_count = 0
	print("Prompt count has been reset.")

func display_ai_response(response):
	# gets the type of the response
	var type_of_variable = typeof(response)

	if type_of_variable == TYPE_DICTIONARY:
		# if the type of response is dictionary gets the allocated response from the chat bot
		var response_string = response["response"]
		var response_length = response_string.length()
		
		# Adds bot response
		text_edit.text += "Bot:" + response_string + "\n"
		
		# If we have 6 prompts then look at bot response as to whether we are human or AI
		if prompt_count == 6:
			reset_prompt_count()
			if response_string[response_length - 1] == "h" or "human" in response_string:
				text_edit.text += "The bot has detected you are human, you lose!"
				emit_signal("death")
				result_button.visible = true  # Make the button visible
				win = false
			else:
				text_edit.text += "The bot has detected you are an AI, you win!"
				emit_signal("increment")
				win = true
				result_button.visible = true  # Make the button visible

func resume_ai():
	if win == false:
		parent_ai.resume(true)
		Globals.on_death()
	else:
		parent_ai.resume(false)
		Globals.on_bamboozle()
