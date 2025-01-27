extends Control

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	# You can perform any setup for your menu here if needed
	pass

func _on_Continue_pressed() -> void:
	pass

# Signal handler for the "New Game" button
func _on_New_Game_pressed() -> void:
	# Change the scene to Level1
	get_tree().change_scene_to_file("res://Scenes/Level1.tscn")

func _on_Load_Game_pressed() -> void:
	pass
	
func _on_Options_pressed() -> void:
	pass

func _on_Exit_pressed() -> void:
	pass
	
