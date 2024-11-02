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

	# Connect the request_completed signal
	http_request.connect("request_completed", self, "_on_request_completed")

func _on_request_completed(result, response_code, headers, body):
	if response_code == 200:
		var json_instance = JSON.new()
		var json = json_instance.parse(body)
		print("GET response:", json.result["message"])
	else:
		print("GET request failed with response code:", response_code)

func send_post_request(data):
	var json_data = JSON.stringify(data)
	http_request.request("http://127.0.0.1:5000/api/data", [], true, HTTPClient.METHOD_POST, json_data)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
