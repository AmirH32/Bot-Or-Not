extends Node2D

@export var nav : NavigationAgent2D
@export var rot_speed : float = 1
@export var speed : float = 50
@export var angle_tolerance : float = 0.1
@export var path : Array[Vector2]
@export var human_detector : Area2D
@export var xrayvision : bool = false
@export var view_dist : float = 500
@export var fov : float = 90
@export var human_detector_poly : CollisionPolygon2D
var hostile = true
var current_path : int
var rel_target : Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_path = 0
	nav.target_position=path[current_path]
	human_detector_poly.polygon = PackedVector2Array([Vector2(0, 0), Vector2(view_dist, -view_dist*sin(fov)), Vector2(view_dist, view_dist*sin(fov))])


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (hostile and human_detector.has_overlapping_bodies()):
		print("target acquired")
		var space_state = get_world_2d().direct_space_state
		var detected = human_detector.get_overlapping_bodies()[0]
		var query = PhysicsRayQueryParameters2D.create(global_position, detected.global_position)
		var result = space_state.intersect_ray(query)
		if (xrayvision or (result and result["collider"]==detected)):
			nav.target_position=detected.global_position
			
		else:
			print("target is behind wall")
		
	rel_target = nav.get_next_path_position()-global_position
	rotation = rotate_toward(rotation, rel_target.angle(), delta * rot_speed)
	if abs(angle_difference(rel_target.angle(),rotation))<angle_tolerance:
		position += move_toward(0, rel_target.length(), speed*delta)*Vector2.RIGHT.rotated(rotation)


func _on_ai_navigation_target_reached() -> void:
	pass


func _on_ai_navigation_navigation_finished() -> void:
	current_path= (current_path+1)%path.size()
	nav.target_position=path[current_path]
	print(nav.target_position)
	


func _on_human_collider_body_entered(body: Node2D) -> void:
	#if body is player
	hostile=false
	human_detector.monitoring=false