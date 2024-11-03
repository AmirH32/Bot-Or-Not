extends Node


var level: Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func start_game(level_name: String):
	level = load("res://scenes/levels/"+level_name+".tscn").instantiate()
	var win_area: WinArea = level.get_node("WinArea")
	win_area.win.connect(win)
	add_child(level)
	$UI.hide()

func reset_level():
	$UI.show()
	remove_child(level)
	level.queue_free()


func win(_num_bamboozled: int):
	reset_level()
	$UI.win()


func die():
	reset_level()
	$UI.die()
