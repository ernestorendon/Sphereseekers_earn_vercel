extends Node3D

var controls_menu_instance = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var environment = Environment.new()
	var bg_color = Color(0.68, 0.85, 0.9) 
	environment.background_mode = Environment.BG_COLOR
	environment.background_color = bg_color
	
	var world = get_viewport().get_world_3d()
	world.environment = environment
	
	if not Global.controls_shown:
		Global.controls_shown = true
		call_deferred("_load_controls_menu")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
func _load_controls_menu():
	var controls_scene = load("res://Scenes/Interface/ControlsMenu.tscn")
	controls_menu_instance = controls_scene.instantiate()
	
	add_child(controls_menu_instance)
	
	get_tree().paused = true
