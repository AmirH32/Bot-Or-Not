extends Node2D

@export var nav : NavigationAgent2D
@export var rot_speed : float = 1
@export var speed : float = 50
@export var angle_tolerance : float = 0.1
@export var path : Array[Vector2]
@export var human_detector : Area2D
var current_path : int
var rel_target : Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_path = 0
	nav.target_position=path[current_path]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rel_target = nav.get_next_path_position()-global_position
	rotation = rotate_toward(rotation, rel_target.angle(), delta * rot_speed)
	print(angle_difference(rel_target.angle(),rotation))
	if abs(angle_difference(rel_target.angle(),rotation))<angle_tolerance:
		position += move_toward(0, rel_target.length(), speed*delta)*Vector2.RIGHT.rotated(rotation)


func _on_ai_navigation_target_reached() -> void:
	pass


func _on_ai_navigation_navigation_finished() -> void:
	current_path= (current_path+1)%path.size()
	nav.target_position=path[current_path]
	print(nav.target_position)
