extends Node


# Reference the TextEdit and Answer (input field) nodes
@onready var text_edit = $TextEdit      # Main TextEdit box
@onready var answer_input = $Answer      # Input field (e.g., LineEdit or another TextEdit)
@onready var http_request_node = $HTTPRequest # The HTTP Request node
var prompt_count: int = 0 # initialise prompt count

func create_post_data(prompt, prompt_count):
	var post_data = {
			"prompt": prompt,
			"count": prompt_count  # You can increment this counter if needed
	}
	return post_data
	
# On startup get the first question from AI
func _ready() -> void:
	http_request_node.get_first_question()
	
	
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
			post_data = create_post_data("You must now judge whether the person you have talked to is a human or a robot, your life depends on this decision, make a concise decision and send it (your answer must include if you think they are a human or a robot)",prompt_count)
			
			http_request_node.send_post_request(post_data)
			
			prompt_count = 0
			print("Prompt count has been reset.")
			
		###
		
		
		# Clear the input field after sending the text
		answer_input.text = ""
	else:
		print("One or more nodes not found! Check the path.")

func display_ai_response(response):
	var type_of_variable = typeof(response)

	if type_of_variable == TYPE_DICTIONARY:
		text_edit.text += "Bot:" + response["response"] + "\n"
	
