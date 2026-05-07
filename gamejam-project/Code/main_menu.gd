extends Control

@onready var main_menu_container: VBoxContainer = $CanvasLayer/MainMenuContainer
@onready var difficulty_menu = $CanvasLayer/DifficultyContainer


func _ready():
	main_menu_container.show()
	difficulty_menu.hide()
	$CanvasLayer/SettingsUI.hide()
	ScoreSystem.hide()
	
	
func _on_start_button_pressed():
	main_menu_container.hide()
	difficulty_menu.show()
	
	
func _on_quit_button_pressed():
	get_tree().quit()
	

func _on_settings_button_pressed() -> void:
	$CanvasLayer/MainMenuContainer.hide()
	$CanvasLayer/SettingsUI.show()
	
	
func _on_back_button_pressed() -> void:
	$CanvasLayer/SettingsUI.hide()
	$CanvasLayer/MainMenuContainer.show()
	
	
func _on_easy_pressed() -> void:
	ScoreSystem.show()
	ScoreSystem.start_scoring()
	$AudioStreamPlayer.stop()
	GameManager.load_level("res://Scenes/level_1.tscn", 0)


func _on_normal_pressed() -> void:
	ScoreSystem.show()
	ScoreSystem.start_scoring()
	$AudioStreamPlayer.stop()
	GameManager.load_level("res://Scenes/level_2.tscn", 1)


func _on_hard_pressed() -> void:
	ScoreSystem.show()
	ScoreSystem.start_scoring()
	$AudioStreamPlayer.stop()
	GameManager.load_level("res://Scenes/level_3.tscn", 2)


func _on_volume_slider_value_changed(value: float) -> void:
	var bus_index = AudioServer.get_bus_index("Master")
	var volume_db = linear_to_db(value)
	
	AudioServer.set_bus_volume_db(bus_index, volume_db)

	AudioServer.set_bus_mute(bus_index, value < 0.01)
