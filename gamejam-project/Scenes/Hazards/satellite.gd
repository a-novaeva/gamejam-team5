extends Area2D

@export var speed: float = 150.0 

# Rename variable to 'sprite' to avoid conflict with the class name 'AnimatedSprite2D'
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

var left_bound: float = -64.0
var right_bound: float = 832.0

func _process(delta: float) -> void:
	# Movement logic
	position.x += speed * delta
	
	# Flip the sprite based on direction using the 'sprite' variable
	sprite.flip_h = (speed < 0)
	
	# Screen wrap-around logic
	if speed > 0 and position.x > right_bound:
		position.x = left_bound
	elif speed < 0 and position.x < left_bound:
		position.x = right_bound
