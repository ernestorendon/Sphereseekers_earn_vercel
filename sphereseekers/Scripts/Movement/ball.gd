extends RigidBody3D
@export var movement_speed : float = 98500.0
@export var max_velocity : float = 20.0

@onready var camera_3d: Camera3D = $"../CameraRig/HRotation/VRotation/SpringArm3D/Camera3D"


func _physics_process(delta):
	linear_velocity.x = clamp(linear_velocity.x, -max_velocity, max_velocity)
	linear_velocity.z = clamp(linear_velocity.z, -max_velocity, max_velocity)
	
	movement(delta)
	pass

func movement(delta) :
	var f_input = Input.get_action_raw_strength("ui_down") - Input.get_action_raw_strength("ui_up")
	var h_input = Input.get_action_raw_strength("ui_right") - Input.get_action_raw_strength("ui_left")
	
	var camera_tranform = camera_3d.get_camera_transform()
	var relative_camera_direction_z = camera_tranform.basis.z.normalized()
	var relative_camera_direction_x = camera_tranform.basis.x.normalized()
	
	var direction_f = f_input * relative_camera_direction_z
	var direction_h = h_input * relative_camera_direction_x
	
	apply_central_force(direction_f * movement_speed * delta)
	apply_central_force(direction_h * movement_speed * delta)
	pass

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
