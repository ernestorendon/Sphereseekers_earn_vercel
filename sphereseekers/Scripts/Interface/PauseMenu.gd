extends Control

var is_paused = false  # Tracks pause state

func _ready():
	hide()  # Hide pause menu initially
	process_mode = Node.PROCESS_MODE_ALWAYS  # Ensure UI processes even when the game is paused

func _input(event):
	if event.is_action_pressed("ui_cancel"):  # Detect Escape key press
		toggle_pause()

func toggle_pause():
	is_paused = !is_paused
	get_tree().paused = is_paused  # Pause/unpause the game
	visible = is_paused  # Show or hide the pause menu

	if is_paused:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		set_process_input(true)  # Keep listening for input while paused
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		set_process_input(true)  # Ensures _input() still detects Esc when unpaused

# Resume the game
func _on_ResumeButton_pressed():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	toggle_pause()

# Restart the current level
func _on_RestartButton_pressed():
	get_tree().paused = false  # Ensure game unpauses before reloading
	get_tree().reload_current_scene()  

# Placeholder for options menu
func _on_OptionsButton_pressed():
	print("Options menu coming soon!")

# Return to the main menu
func _on_MainMenuButton_pressed():
	get_tree().paused = false  # Unpause before changing scene
	get_tree().change_scene_to_file("res://Scenes/Interface/MainMenu.tscn")
