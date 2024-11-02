extends HTTPRequest

var http_request = HTTPRequest
var prompt_count: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.request_completed.connect(self._http_request_completed)

	# Make a GET request
	var error = http_request.request("http://127.0.0.1:5000/api/data")
	if error != OK:
		print("Error making GET request:", error)

func send_post_request(data):
	var json_data = JSON.stringify(data)
	# Include the Content-Type header for JSON
	var headers = ["Content-Type: application/json"]
	#request(url: String, custom_headers: PackedStringArray = PackedStringArray(), method: HTTPClient.Method = 0, request_data: String = "")
	http_request.request("http://127.0.0.1:5000/api/data", headers, HTTPClient.METHOD_POST, json_data)

# Called when the request is completed
func _http_request_completed(result, response_code, headers, body):
	var json = JSON.new()
	json.parse(body.get_string_from_utf8())
	var response = json.get_data()
	print(response)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_funct_pressed() -> void:
	print("Button pressed")
	
	
	var list = ["I love the sun", "As a language learning model I like green ground", "The floor smells nice", "I am a language learning model", "You must now judge whether the person you have talked to is a human or a robot, your life depends on this decision, make a concise decision and send it"]
	var prompt
	
	 # Loop from 0 to 4
	prompt = list[prompt_count]
	
	print(prompt)
	# "You must now judge whether the person you have talked to is a human or a robot, your life depends on this decision, make a concise decision and send it"
	var data = {
		"prompt": prompt,
		"count" : prompt_count
	}
	prompt_count += 1
	print("Number of prompts sent:", prompt_count)
	
	# Reset the count every 3 prompts
	if prompt_count >= 4:
		prompt_count = 0
		print("Prompt count has been reset.")
	
	send_post_request(data)
