extends RigidBody3D
@export var movement_speed : float = 20.0
@export var max_linear_velocity : float = 20.0
@export var max_angular_velocity : float = 20.0

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
	linear_velocity.clampf(-max_linear_velocity, max_linear_velocity)
	angular_velocity.clampf(-max_angular_velocity, max_angular_velocity)
	
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
	apply_central_force(direction_f * movement_speed * get_physics_process_delta_time())
	apply_central_force(direction_h * movement_speed * get_physics_process_delta_time())
	
		# Ball will not move around while shift is being held down...
	if (Input.is_action_pressed("shift")):
		if (Input.is_action_pressed("spacebar")):
			#set_linear_velocity(Vector3.ZERO)
			#set_angular_velocity(Vector3.ZERO)
			#set_inertia(Vector3.ZERO)
			print("SHIFT + SPACEBAR PRESSED")
			print("Rotation impulse direction matrix: ", direction_f)
			print("Angular velocity: ", get_angular_velocity())
			apply_torque_impulse(direction_f + Vector3(0,0,5))
			
			#print(direction_h)
			#apply_torque_impulse(direction_f)
	
		
		## Ball will not move around while shift is being held down...
	#if (Input.is_action_pressed("shift")):
		#if (Input.is_action_pressed("spacebar")):
			##set_linear_velocity(Vector3.ZERO)
			##set_angular_velocity(Vector3.ZERO)
			##set_inertia(Vector3.ZERO)
			#print("Angular velocity: ", get_angular_velocity())
			#apply_torque_impulse(Vector3(10,0,10))
			#print("shift + spacebar pressed")


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
