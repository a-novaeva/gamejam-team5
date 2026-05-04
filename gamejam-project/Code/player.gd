extends CharacterBody2D

# Adjust this to match your background tile size in pixels
@export var tile_size: int = 64

# Controls how fast the visual jump happens
@export var move_speed: float = 0.15 

var is_moving: bool = false
var target_position: Vector2 = Vector2.ZERO

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	position = position.snapped(Vector2(tile_size, tile_size))
	target_position = position

func _physics_process(_delta: float) -> void:
	if is_moving:
		position = position.move_toward(target_position, tile_size * (1.0 / move_speed) * _delta)
		
		if position == target_position:
			is_moving = false
			if sprite.is_playing() and sprite.animation == "jump":
				sprite.play("idle")
	else:
		var input_direction = get_input_direction()
		if input_direction != Vector2.ZERO:
			move_to_tile(input_direction)

func get_input_direction() -> Vector2:
	var dir = Vector2.ZERO
	
	if Input.is_action_just_pressed("move_up"):
		dir = Vector2.UP
	elif Input.is_action_just_pressed("move_down"):
		dir = Vector2.DOWN
	elif Input.is_action_just_pressed("move_left"):
		dir = Vector2.LEFT
	elif Input.is_action_just_pressed("move_right"):
		dir = Vector2.RIGHT
	return dir

func move_to_tile(direction: Vector2) -> void:
	target_position = position + direction * tile_size
	is_moving = true
	
	update_sprite_orientation(direction)
	
	if sprite.sprite_frames.has_animation("jump"):
		sprite.play("jump")

func update_sprite_orientation(direction: Vector2) -> void:
	if direction == Vector2.UP:
		sprite.rotation_degrees = 0
	elif direction == Vector2.DOWN:
		sprite.rotation_degrees = 180
	elif direction == Vector2.LEFT:
		sprite.rotation_degrees = 270
	elif direction == Vector2.RIGHT:
		sprite.rotation_degrees = 90
