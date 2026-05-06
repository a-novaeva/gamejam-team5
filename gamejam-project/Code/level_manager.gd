extends Node

var goals_filled: int = 0
@export var total_goals: int = 5

func _ready():
	$Spacefrog.goal_reached.connect(_on_goal_reached)

func _on_goal_reached():
	goals_filled += 1
	print("Goals: ", goals_filled, "/", total_goals)
	
	if goals_filled >= total_goals:
		win_level()

func win_level():
	print("You Win!")
	get_tree().change_scene_to_file("res://Scenes/win_screen.tscn")
