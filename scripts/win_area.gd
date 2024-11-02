extends Area2D

var enemy_in_area := false

signal win

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float):
	pass




func _on_player_entered(_body: PhysicsBody2D):
	enemy_in_area = false
	await get_tree().create_timer(2.0).timeout
	if not enemy_in_area:
		win.emit()


func _on_enemy_entered(_body: PhysicsBody2D):
	enemy_in_area = true
