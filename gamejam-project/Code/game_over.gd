extends Control

	
func _on_try_again_pressed() -> void:
	if GameManager.last_played_scene != "":
		get_tree().change_scene_to_file(GameManager.last_played_scene)
		ScoreSystem.reset_game()
	else:
		get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
	
func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _process(_delta):
	if $AudioStreamPlayer.get_playback_position() >= 20:
		$AudioStreamPlayer.play()
