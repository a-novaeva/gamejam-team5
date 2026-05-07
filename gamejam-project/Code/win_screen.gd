extends Control

func _ready():
	var label = get_node("ScoreLabel")

	if label:
		label.text = "Total Score: " + str(GameManager.total_score)
	else:
		print("Check your scene tree")
	
func _on_play_again_pressed() -> void:
	ScoreSystem.reset_game()
	get_tree().change_scene_to_file("res://Scenes/level_1.tscn")


func _on_main_menu_pressed() -> void:
	ScoreSystem.reset_game()
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
