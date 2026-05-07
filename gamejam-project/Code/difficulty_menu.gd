extends Control


func _on_easy_pressed():
	get_tree().change_scene_to_file("res://Scenes/level_1.tscn")


func _on_normal_pressed():
	get_tree().change_scene_to_file("res://Scenes/level_2.tscn")


func _on_hard_pressed():
	pass # Replace with function body.
