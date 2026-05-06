extends Control

func _on_try_again_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/level_1.tscn")
	
func _on_quit_button_pressed() -> void:
	get_tree().quit()
