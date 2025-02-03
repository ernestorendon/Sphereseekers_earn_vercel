extends RigidBody3D

# Default speed if not set
@export var movement_speed: float = 10.0 
# The initial position of the ball
@export var original_position: Vector3  
# Target position for the ball
@export var target_position: Vector3 
# In case we want the canonballs to go down
@export var y_speed: float = 0.0 
 # In case we want to avoid all the balls get shoot at the same time
@export var delay: bool = false

func _ready() -> void:
	original_position = global_transform.origin
	# If target_position isn't set, assume it's the opposite X of original position
	if target_position == Vector3.ZERO:
		target_position = Vector3(-original_position.x, original_position.y, original_position.z)
	
	if delay:
		# Not workin ...
		get_tree().create_timer(5).timeout

func _physics_process(_delta: float) -> void:
	# Move the ball along X axis towards target
	linear_velocity = Vector3(
		sign(target_position.x - global_transform.origin.x) * movement_speed, 
		y_speed, 
		0
	)
	
	# Check if ball has reached target (with small tolerance)
	if abs(global_transform.origin.x - target_position.x) < 1:
		# Reset position to original X
		var reset_position = global_transform.origin
		reset_position.x = original_position.x
		global_transform.origin = reset_position
		# Stop movement
		linear_velocity = Vector3.ZERO
