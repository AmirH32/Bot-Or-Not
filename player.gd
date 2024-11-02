extends CharacterBody2D

# Speed of the player
const SPEED = 200.0

func _physics_process(delta: float) -> void:
	# Initialize velocity to zero
	velocity = Vector2.ZERO
	
	# Get input direction and apply speed
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	
	# Normalize the velocity to ensure uniform speed in all directions
	if velocity != Vector2.ZERO:
		velocity = velocity.normalized() * SPEED

	# Move the player using the updated velocity
	move_and_slide()
