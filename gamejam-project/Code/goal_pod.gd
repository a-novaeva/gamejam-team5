extends Area2D

var is_occupied: bool = false
@onready var occupied_sprite = $OccupiedSprite

func _ready():
	occupied_sprite.visible = false
	add_to_group("GoalPods")

func fill_goal():
	is_occupied = true
	occupied_sprite.visible = true
