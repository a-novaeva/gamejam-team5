extends Control


var last_played_scene: String = ""

func load_level(scene_path: String):
	last_played_scene = scene_path
	get_tree().change_scene_to_file(scene_path)
	
func _on_try_again_pressed() -> void:
	ScoreSystem.reset_game()
	if GameManager.last_played_scene != "":
		get_tree().change_scene_to_file(GameManager.last_played_scene)
	
func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _process(_delta):
	if $AudioStreamPlayer.get_playback_position() >= 20:
		$AudioStreamPlayer.play()
