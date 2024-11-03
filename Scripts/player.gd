extends CharacterBody2D

# Constants
const ACCELERATION = 1000.0  # How quickly the player speeds up
const MAX_SPEED = 300.0     # Maximum speed of the player
const FRICTION = 1000.0      # How quickly the player slows down when no input

# _physics_process is called every frame with the delta time
func _physics_process(delta: float) -> void:
	# Calculate acceleration based on input
	var input_direction = Vector2.ZERO

	if Input.is_action_pressed("ui_right"):
		input_direction.x += 1
	if Input.is_action_pressed("ui_left"):
		input_direction.x -= 1
	if Input.is_action_pressed("ui_down"):
		input_direction.y += 1
	if Input.is_action_pressed("ui_up"):
		input_direction.y -= 1

	# Normalize the input direction to avoid faster diagonal movement
	if input_direction != Vector2.ZERO:
		input_direction = input_direction.normalized()

	# Accelerate based on input direction
	velocity += input_direction * ACCELERATION * delta

	# Apply friction to slow down when no input is given
	if input_direction == Vector2.ZERO:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)

	# Limit the velocity to the maximum speed
	if velocity.length() > MAX_SPEED:
		velocity = velocity.normalized() * MAX_SPEED

	# Move the player using the updated velocity
	move_and_slide()
