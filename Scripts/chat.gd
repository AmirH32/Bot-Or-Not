extends Node


# Reference the TextEdit and Answer (input field) nodes
@onready var text_edit = $TextEdit       # Main TextEdit box
@onready var answer_input = $Answer      # Input field (e.g., LineEdit or another TextEdit)
@onready var http_request_node = $HTTPRequest # The HTTP Request node
var prompt_count: int = 0 # initialise prompt count


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
		
		# POST and send the answer_input
		var post_data = {
			"prompt": user_input,
			"count": prompt_count  # You can increment this counter if needed
		}
		
		http_request_node.send_post_request(post_data)
		
		
		# Clear the input field after sending the text
		answer_input.text = ""
	else:
		print("One or more nodes not found! Check the path.")
