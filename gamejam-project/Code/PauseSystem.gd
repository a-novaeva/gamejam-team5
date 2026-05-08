extends CanvasLayer


func toggle_pause():
	var is_paused = !get_tree().paused
	get_tree().paused = is_paused		
	
	if is_paused:
		$PauseMenu.show()
	else:
		$PauseMusicPlayer.stop()
		$PauseMenu.hide()
		$SettingsUI.hide()
		
		
func _on_resume_pressed() -> void:
	toggle_pause()
	
	
func _on_volume_slider_value_changed(value: float) -> void:
	var bus_index = AudioServer.get_bus_index("Master")
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))


func _on_settings_button_pressed() -> void:
	$PauseMenu.hide()
	$SettingsUI.show()


func _on_main_menu_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")


func _on_volume_slider_drag_started() -> void:
	$PauseMusicPlayer.play()


func _on_volume_slider_drag_ended(_value_changed: bool) -> void:
	$PauseMusicPlayer.stop()


func _on_back_button_pressed() -> void:
	$SettingsUI.hide()
	$PauseMenu.show()
