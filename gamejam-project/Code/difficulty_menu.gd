extends Control


func _on_easy_pressed():
	GameManager.current_difficulty = GameManager.Difficulty.EASY
	get_tree().change_scene_to_file("res://Scenes/level_1.tscn")


func _on_normal_pressed():
	GameManager.current_difficulty = GameManager.Difficulty.MEDIUM
	get_tree().change_scene_to_file("res://Scenes/level_2.tscn")


func _on_hard_pressed():
	pass # Replace with function body.
