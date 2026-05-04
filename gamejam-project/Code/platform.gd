extends Area2D

@export var velocity: Vector2 = Vector2(-100, 0)

var screen_min_x: float = -128.0
var screen_max_x: float = 832.0

func _process(delta: float) -> void:
	position += velocity * delta

	if velocity.x < 0 and position.x < screen_min_x:
		position.x = screen_max_x

	elif velocity.x > 0 and position.x > screen_max_x:
		position.x = screen_min_x
