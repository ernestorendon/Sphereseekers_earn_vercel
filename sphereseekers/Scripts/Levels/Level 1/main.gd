extends Node3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var environment = Environment.new()
	var bg_color = Color(0.68, 0.85, 0.9) 
	environment.background_mode = Environment.BG_COLOR
	environment.background_color = bg_color
	
	var world = get_viewport().get_world_3d()
	world.environment = environment

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
