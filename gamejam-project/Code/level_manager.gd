extends Node

var goals_filled: int = 0
@export var total_goals: int = 5

func _ready():
	$Spacefrog.goal_reached.connect(_on_goal_reached)
	ScoreSystem.start_scoring()

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		toggle_pause()
		

func toggle_pause():
	var is_paused = !get_tree().paused
	get_tree().paused = is_paused		
	
	if is_paused:
		$PauseLayer/PauseMenu.show()
	else:
		$PauseLayer/PauseMenu.hide()
		$PauseLayer/SettingsUI.hide()
		
func _on_goal_reached():
	goals_filled += 1
	print("Goals: ", goals_filled, "/", total_goals)
	
	if goals_filled >= total_goals:
		win_level()

func win_level():
	GameManager.total_score = ScoreSystem.current_score
	get_tree().change_scene_to_file("res://Scenes/win_screen.tscn")


func _on_resume_pressed() -> void:
	toggle_pause()


func _on_settings_button_pressed() -> void:
	$PauseLayer/PauseMenu.hide()
	$PauseLayer/SettingsUI.show()


func _on_back_button_pressed() -> void:
	$PauseLayer/SettingsUI.hide()
	$PauseLayer/PauseMenu.show()


func _on_main_menu_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
