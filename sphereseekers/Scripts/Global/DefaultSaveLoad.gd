extends Node

# Needs testing when we export to mobile
const FILE_NAME = "user://player-data.tres"

func savePlayerData(player):
	ResourceSaver.save(player, FILE_NAME)

func loadPlayerData():
	if ResourceLoader.exists(FILE_NAME):
		return ResourceLoader.load(FILE_NAME)
	return null
	
