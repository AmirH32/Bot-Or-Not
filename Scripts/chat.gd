extends Node

# Reference the TextEdit and Answer (input field) nodes
@onready var text_edit = $TextEdit       # Main TextEdit box
@onready var answer_input = $Answer      # Input field (e.g., LineEdit or another TextEdit)

# Function called when the Send button is pressed
func _on_send_pressed():
	# Confirm the button is triggering this function
	print("Button pressed - Sending input text")
	
	# Verify if the text_edit and answer_input nodes are accessible
	if text_edit and answer_input:
		print("TextEdit and Answer nodes found - Adding input text")
		
		# Append the text from the Answer input field to the TextEdit box
		text_edit.text += answer_input.text + "\n"
		
		# Clear the input field after sending the text
		answer_input.text = ""
	else:
		print("One or more nodes not found! Check the path.")
