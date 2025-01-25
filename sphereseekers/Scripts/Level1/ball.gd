extends RigidBody3D

@export var movement_speed: float = 5.0
@export var rotation_speed: float = 2.0

# Temporal movement for testing

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	var input_direction = Vector3.ZERO
	if Input.is_action_pressed("ui_up"):
		input_direction.z -= 0.01
	if Input.is_action_pressed("ui_down"):
		input_direction.z += 0.01
	if Input.is_action_pressed("ui_left"):
		input_direction.x -= 0.01
	if Input.is_action_pressed("ui_right"):
		input_direction.x += 0.01

	if input_direction != Vector3.ZERO:
		input_direction = input_direction.normalized()

	apply_central_force(input_direction * movement_speed)
	var torque = Vector3(-input_direction.z, 0, input_direction.x) * rotation_speed
	apply_torque_impulse(torque)

# Collision detection method
func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("enemy_balls"):
		reset_position()
	if body.is_in_group("exit"):
		print("GG WP")

# Resets player position to (0, 5, -67.5)
func reset_position() -> void:
	linear_velocity = Vector3.ZERO # Stop ball
	var new_transform = global_transform
	new_transform.origin = Vector3(0, 5, -67.5) # Set position to (0, 5, -67.5)
	global_transform = new_transform
