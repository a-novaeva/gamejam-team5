extends Control

@onready var main_menu_container: VBoxContainer = $CanvasLayer/MainMenuContainer
@onready var difficulty_menu = $CanvasLayer/DifficultyContainer


func _ready():
	main_menu_container.show()
	difficulty_menu.hide()
	ScoreSystem.hide()
	
func _on_start_button_pressed():
	main_menu_container.hide()
	difficulty_menu.show()
	
func _on_quit_button_pressed():
	get_tree().quit()

func _on_settings_button_pressed() -> void:
	pass # Replace with function body.


func _on_easy_pressed() -> void:
	ScoreSystem.show()
	ScoreSystem.start_scoring()
	GameManager.load_level("res://Scenes/level_1.tscn", 0)


func _on_normal_pressed() -> void:
	ScoreSystem.show()
	ScoreSystem.start_scoring()
	GameManager.load_level("res://Scenes/level_2.tscn", 1)


func _on_hard_pressed() -> void:
	ScoreSystem.show()
	ScoreSystem.start_scoring()
	pass # Replace with function body.
