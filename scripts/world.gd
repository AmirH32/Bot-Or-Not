extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	start_game("level_1")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func start_game(level_name: String):
	add_child(load("res://scenes/levels/"+level_name+".tscn").instantiate())
	#$UI.hide()
