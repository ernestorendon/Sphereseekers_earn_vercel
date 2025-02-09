extends Control

const MOBILE_KEYWORDS = ["Android", "iPhone", "iPad", "iPod", "Windows Phone", "Mobile"]

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	# You can perform any setup for your menu here if needed
	Global.is_mobile = is_running_on_mobile_browser()
	pass

func _on_Continue_pressed() -> void:
	pass

# Signal handler for the "New Game" button
func _on_New_Game_pressed() -> void:
	# Change the scene to Level1
	Global.is_paused = false
	get_tree().change_scene_to_file("res://Scenes/Levels/Tutorial.tscn")

func _on_Load_Game_pressed() -> void:
	pass
	
func _on_Options_pressed() -> void:
	pass

func _on_Exit_pressed() -> void:
	pass
	
func is_running_on_mobile_browser() -> bool:
	if not OS.has_feature("web"):
		return false
	var user_agent = JavaScriptBridge.eval("navigator.userAgent;")
	for keyword in MOBILE_KEYWORDS:
		if keyword in user_agent:
			return true
	return false
