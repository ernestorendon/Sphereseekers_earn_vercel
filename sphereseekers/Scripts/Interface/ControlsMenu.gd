extends Control

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _on_continue_pressed():
	queue_free()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

	get_tree().paused = false
