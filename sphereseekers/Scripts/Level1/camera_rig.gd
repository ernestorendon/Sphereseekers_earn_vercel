extends Node3D

# Path to the ball node
@export var ball_path: NodePath 
# Camera offset
@export var offset: Vector3 = Vector3(0, 5, -5) 
# Smoothing factor
@export var smooth_speed: float = 5.0 

var ball: Node3D 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if ball_path:
		ball = get_node(ball_path) as Node3D
	else:
		print("ball_path is not set.")

func _physics_process(delta: float) -> void:
	if not ball:
		return
	
	# Calculate the target position (ball's position + offset)
	var target_position = ball.global_position + offset

	# Smoothly interpolate towards the target position
	global_position = global_position.lerp(target_position, smooth_speed * delta)
