extends HTTPRequest

var http_request = HTTPRequest

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	http_request = HTTPRequest.new()
	add_child(http_request)

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

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_funct_pressed() -> void:
	print("Button pressed")
	var data = {
		"prompt": "I like watermelons"
	}
	send_post_request(data)
