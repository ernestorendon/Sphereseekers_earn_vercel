extends Control

const DESKTOP_OS_LIST = ["Windows", "Linux", "macOS"]

func _ready():
	
	var background = $Background
	var label = $Label
	var image = $Image
	var button = $Button
	
	if is_running_on_desktop():
		set_objects_for_desktop(background, label, image, button)
	else:
		# we assume that is a smartphone
		set_objects_for_smartphone(background, label, image, button)
	
	process_mode = Node.PROCESS_MODE_ALWAYS
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_continue_pressed():
	queue_free()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	get_tree().paused = false
	
func is_running_on_desktop() -> bool:
	return OS.get_name() in DESKTOP_OS_LIST
	
func set_objects_for_desktop(background, label, image, button):
	var screen_size = get_viewport_rect().size
	var width = screen_size.x
	var height = screen_size.y

	# Background (ColorRect)
	background.set_size(Vector2(width * 0.8, height * 0.7))
	background.set_position(Vector2(width * 0.1, height * 0.15))
	background.color = Color(0, 0, 0, 0.5)

	# Background position
	var bg_size = background.size
	var bg_position = background.position

	# Label (Title)
	label.text = "How to play"
	label.set_size(Vector2(bg_size.x * 0.6, bg_size.y * 0.15))
	label.set_position(Vector2(
		bg_position.x + (bg_size.x - label.size.x) / 2,
		bg_position.y + bg_size.y * 0.05
	))
	label.add_theme_font_size_override("font_size", 48)
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	
	# Image (TextureRect)
	image.texture = load("res://Assets/ArrowKeys.png")
	var image_scale_factor = 0.4
	var max_image_height = bg_size.y * 0.3

	if image.texture:
		var texture_size = image.texture.get_size()
		var aspect_ratio = texture_size.x / float(texture_size.y)

		var new_width = bg_size.x * image_scale_factor
		var new_height = new_width / aspect_ratio

		if new_height > max_image_height:
			new_height = max_image_height
			new_width = new_height * aspect_ratio

		image.set_size(Vector2(new_width, new_height))

	image.set_position(Vector2(
		bg_position.x + (bg_size.x - image.size.x) / 2,
		bg_position.y + bg_size.y * 0.3
	))

	# Button
	button.text = "Continue"
	button.set_size(Vector2(bg_size.x * 0.25, bg_size.y * 0.1))

	button.set_position(Vector2(
		bg_position.x + (bg_size.x - button.size.x) / 2,
		bg_position.y + bg_size.y * 0.75
	))
	
func set_objects_for_smartphone(background, label, image, button):
	var screen_size = get_viewport_rect().size
	var width = screen_size.x
	var height = screen_size.y

	# Background (ColorRect)
	background.set_size(Vector2(width * 0.9, height * 0.85))
	background.set_position(Vector2(width * 0.05, height * 0.075))
	background.color = Color(0, 0, 0, 0.5)

	# Background position
	var bg_size = background.size
	var bg_position = background.position

	# Label (Title)
	label.text = "How to play"
	label.set_size(Vector2(bg_size.x * 0.8, bg_size.y * 0.1))
	label.set_position(Vector2(
		bg_position.x + (bg_size.x - label.size.x) / 2,
		bg_position.y + bg_size.y * 0.03
	))
	label.add_theme_font_size_override("font_size", 36)
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER

	# Image (TextureRect)
	image.texture = load("res://Assets/Phone.png")
	var image_scale_factor = 0.6
	var max_image_height = bg_size.y * 0.35

	if image.texture:
		var texture_size = image.texture.get_size()
		var aspect_ratio = texture_size.x / float(texture_size.y)

		var new_width = bg_size.x * image_scale_factor
		var new_height = new_width / aspect_ratio

		if new_height > max_image_height:
			new_height = max_image_height
			new_width = new_height * aspect_ratio

		image.set_size(Vector2(new_width, new_height))

	image.set_position(Vector2(
		bg_position.x + (bg_size.x - image.size.x) / 2,
		bg_position.y + bg_size.y * 0.15
	))

	# Button
	button.text = "Continue"
	button.set_size(Vector2(bg_size.x * 0.6, bg_size.y * 0.12))

	button.set_position(Vector2(
		bg_position.x + (bg_size.x - button.size.x) / 2,
		bg_position.y + bg_size.y * 0.8
	))

	
