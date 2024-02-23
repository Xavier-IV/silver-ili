extends Button


# Called when the node enters the scene tree for the first time.
func _ready():
	DirAccess.remove_absolute("user://savegame.save")

	if not FileAccess.file_exists("user://savegame.save"):
		return  # Error! We don't have a save to load.

	text = "Continue"


func _pressed():
	GlobalSave.load()
	get_tree().change_scene_to_file("res://scenes/Game/game_scene.tscn")
