class_name Chat
extends Node2D


# Reference the TextEdit and Answer (input field) nodes
@onready var text_edit = $TextEdit       # Main TextEdit box
@onready var answer_input = $AnswerEdit      # Input field (e.g., LineEdit or another TextEdit)
@onready var http_request_node = $HTTPRequest # The HTTP Request node
@onready var resume_timer = $Timer  # Reference to the Timer node
var prompt_count: int = 0 # initialise prompt count
var parent_ai : AI_robot
var win

signal death
signal increment

func create_post_data(prompt, prompt_count):
	var post_data = {
			"prompt": prompt,
			"count": prompt_count  # You can increment this counter if needed
	}
	return post_data
	
# On startup get the first question from AI
func _ready() -> void:
	win = null
	 # Set the TextEdit to full screen size
	print(get_viewport().size)
	
	text_edit.anchor_left = 0
	text_edit.anchor_top = 0
	text_edit.anchor_right = 1
	text_edit.anchor_bottom = 1
	http_request_node.get_first_question()
	prompt_count += 1
	print("Number of prompts sent:", prompt_count)
	
	### Sets timer	
	resume_timer.wait_time = 2.0  # Set the wait time to 2 seconds
	resume_timer.one_shot = true    # Make it a one-shot timer
	resume_timer.connect("timeout", _on_resume_timer_timeout())  # Connect the timeout signal
	
	
# Function called when the Send button is pressed
func _on_send_pressed():
	# Confirm the button is triggering this function
	print("Button pressed - Sending input text")
	
	# Verify if the text_edit and answer_input nodes are accessible
	if text_edit and answer_input:
		print("TextEdit and Answer nodes found - Adding input text")
		
		var user_input = answer_input.text 
		
		# Append the text from the Answer input field to the TextEdit box
		text_edit.text += "User:" + user_input + "\n"
		
		
		### Handles POST and incrementing counter
		# POST and send the answer_input
		var post_data = create_post_data(user_input, prompt_count)
		
		http_request_node.send_post_request(post_data)
		
		prompt_count += 1
		print("Number of prompts sent:", prompt_count)
		
		# Reset the count every 3 prompts
		if prompt_count >= 4:
			# AI makes its decision
			post_data = create_post_data("You must now judge whether the person you have talked to is a human or a robot, your life depends on this decision (your answer must follow the format 'You are a human! h' or 'You are an AI! a' where the last character is 'a' or 'h' to denote whether you judge them as AI or human",prompt_count)
			
			http_request_node.send_post_request(post_data)
			
		###
		
		
		# Clear the input field after sending the text
		answer_input.text = ""
	else:
		print("One or more nodes not found! Check the path.")

func reset_prompt_count():
	prompt_count = 0
	print("Prompt count has been reset.")

func display_ai_response(response):
	var type_of_variable = typeof(response)

	if type_of_variable == TYPE_DICTIONARY:
		var response_string = response["response"]
		var response_length = response_string.length()
		
		text_edit.text += "Bot:" + response_string.substr(0, response_length - 1) + "\n"
		if prompt_count == 5:
			reset_prompt_count()
			if response_string[response_length - 1] == "h" or "human" in response_string:
				text_edit.text += "The bot has detected you are human, you lose!"
				emit_signal("death")
				win = false
				parent_ai.resume(true)
			else:
				text_edit.text += "The bot has detected you are an AI, you win!"
				emit_signal("increment")
				win = true
				parent_ai.resume(false)

func _on_resume_timer_timeout():
	# Determine if the AI should resume with true or false based on previous logic
	var should_resume = win  # Change this based on your logic
	parent_ai.resume(should_resume)  # Call resume after the timer
