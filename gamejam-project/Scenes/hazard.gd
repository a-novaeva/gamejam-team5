extends Area2D

@export var speed: float = 150.0 

var left_bound: float = -64.0
var right_bound: float = 832.0

func _process(delta: float) -> void:
	position.x += speed * delta
	
	if speed > 0 and position.x > right_bound:
		position.x = left_bound
	elif speed < 0 and position.x < left_bound:
		position.x = right_bound
