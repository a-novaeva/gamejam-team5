extends Control

@onready var intro_label = $Label
@onready var sfx_player = $AudioStreamPlayer

func _ready():
	
	intro_label.visible_ratio = 0.0
	await get_tree().create_timer(0.5).timeout
	
	play_typing_effect()

func play_typing_effect():
	intro_label.modulate.a = 1.0 
	intro_label.visible_ratio = 0.0
	
	sfx_player.play()
	
	var tween = create_tween()
	tween.tween_property(intro_label, "visible_ratio", 1.0, 25.0)
	tween.finished.connect(func(): sfx_player.stop())
	await get_tree().create_timer(30.0).timeout
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")

func _input(event):
	if event.is_action_pressed("ui_accept"):
		get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
		sfx_player.stop()
