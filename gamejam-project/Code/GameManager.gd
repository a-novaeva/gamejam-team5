extends Node

var current_difficulty: int = 0 

var last_played_scene: String = ""

func load_level(scene_path: String, difficulty_index: int):
	last_played_scene = scene_path
	current_difficulty = difficulty_index
	get_tree().change_scene_to_file(scene_path)
