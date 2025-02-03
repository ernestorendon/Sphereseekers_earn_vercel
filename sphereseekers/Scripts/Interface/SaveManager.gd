extends Node

const SAVE_PATH = "user://save_game.dat"  # Save file path

# Stores the last played level
var last_played_level = "res://Scenes/Level1.tscn"

func _ready():
	load_game()  # Load save data when the game starts

# Save the current level
func save_game(level_path: String):
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file:
		file.store_string(level_path)
		file.close()

# Load the saved game state
func load_game():
	if FileAccess.file_exists(SAVE_PATH):
		var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
		last_played_level = file.get_as_text().strip_edges()
		file.close()
	else:
		last_played_level = ""  # No save data found
