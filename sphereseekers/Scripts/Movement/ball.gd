extends RigidBody3D
@export var movement_speed : float = 20.0
@export var max_linear_velocity : float = 20.0
@export var max_angular_velocity : float = 175.0

@onready var camera_3d: Camera3D = $"../CameraRig/HRotation/VRotation/SpringArm3D/Camera3D"


"""
TODO:
	As of now, the movement vector is calculated with respect to the camera's position in 3D space.
	This means that z and x inputs are "dampened" when the camera is looking at the marble from above.
	
	There's gotta be a way to implement the relative camera basis such that it informs relevant directional 
	intention, while keeping the magnitude consistent regardless of where the camera is.
"""
func _integrate_forces(state: PhysicsDirectBodyState3D) -> void:
	
	# Set speed limits for speed and rotation speed of marble
	linear_velocity.z = clamp(linear_velocity.z, -max_linear_velocity, max_linear_velocity)
	linear_velocity.x = clamp(linear_velocity.x, -max_linear_velocity, max_linear_velocity)
	
	angular_velocity.x = clamp(angular_velocity.x, -max_angular_velocity, max_angular_velocity)
	
	# Get inputs from user to calculate intended direction
	var f_input = Input.get_action_raw_strength("ui_down") - Input.get_action_raw_strength("ui_up")
	var h_input = Input.get_action_raw_strength("ui_right") - Input.get_action_raw_strength("ui_left")
	
	# Get position (a/k/a "transform") of camera
	var camera_tranform = camera_3d.get_camera_transform()
	var relative_camera_direction_z = camera_tranform.basis.z.normalized()
	var relative_camera_direction_x = camera_tranform.basis.x.normalized()
	
	# Calculate forward/backward direction relative to camera position
	var direction_f = f_input * relative_camera_direction_z
	
	# Removes ability to "fly" by pointing camera parallel to y-axis and "pushing" or "pulling"
	direction_f.y = 0
	
	# Calculate right/left direction relative to camera position
	var direction_h = h_input * relative_camera_direction_x
	
	print("Forward Before force: ", direction_f)
	print("Horizonatal Before force: ", direction_h)
	print("==========================================")
	print("Linear velocity (magnitude): ", get_linear_velocity().length())
	print("Linear velocity (vector): ", get_linear_velocity())
	print("==========================================")
	print("Angular velocity (magnitude): ", get_angular_velocity())
	print("Angular velocity (vector): ", get_angular_velocity().length())
	apply_central_force(direction_f * movement_speed * get_physics_process_delta_time())
	apply_central_force(direction_h * movement_speed * get_physics_process_delta_time())
	
		# Ball will not move around while shift is being held down...
	if (Input.is_action_pressed("shift")):
		
		#linear_velocity.x = lerp(linear_velocity.x, 0.0, 0.8)
		linear_velocity.x = 0
		linear_velocity.z = 0
		if (Input.is_action_just_pressed("spacebar")):
			print("SHIFT + SPACEBAR PRESSED")
			print("Rotation impulse direction matrix: ", direction_f)
			apply_torque_impulse(Vector3(10,0,0) * 3)
			linear_velocity.x = 0
			linear_velocity.z = 0
			return
			
	if (Input.is_action_just_released("shift")):
		var lil_jump_magnitude = 0.6 # Magnitude of lil jump after releasing charged boost
		var lil_jump_impulse = lil_jump_magnitude * Vector3.ONE
		
		var final_boost_vector = lil_jump_impulse + direction_f # Set direction of boost
		
		var spin_speed = get_angular_velocity().length()
		apply_central_impulse(spin_speed * final_boost_vector) # Apply boost to marble
		
		print("shift released!")


# Collision detection method
func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("enemy_balls"):
		reset_position()
	if body.is_in_group("exit"):
		print("GG WP")

# Resets player position to (0, 5, -67.5)
func reset_position() -> void:
	set_inertia(Vector3.ZERO)
	set_linear_velocity(Vector3.ZERO) # Stop ball
	set_angular_velocity(Vector3.ZERO)
	var new_transform = global_transform
	new_transform.origin = Vector3(0, 5, -67.5) # Set position to (0, 5, -67.5)
	global_transform = new_transform
