extends CharacterBody2D
class_name Player

@export var tile_size: int = 32
@export var move_speed: float = 0.2

var is_moving: bool = false
var target_position: Vector2 = Vector2.ZERO
var current_platform: Area2D = null
var respawn_position: Vector2

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	respawn_position = position
	target_position = position

func _physics_process(_delta: float) -> void:
	if current_platform:
		if "velocity" in current_platform and current_platform.velocity != Vector2.ZERO:
			var drift = current_platform.velocity * _delta
			global_position += drift

			if is_moving:
				target_position += drift

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
	if Input.is_action_just_pressed("move_up"): dir = Vector2.UP
	elif Input.is_action_just_pressed("move_down"): dir = Vector2.DOWN
	elif Input.is_action_just_pressed("move_left"): dir = Vector2.LEFT
	elif Input.is_action_just_pressed("move_right"): dir = Vector2.RIGHT
	return dir

func move_to_tile(direction: Vector2) -> void:
	var next_position = position + direction * tile_size
	
	var min_y: float = 16.0
	var max_y: float = 882.0

	if next_position.y < min_y or next_position.y > max_y:
		return

	current_platform = null 
	target_position = next_position
	is_moving = true
	
	if direction == Vector2.UP:
		sprite.play("back")
		sprite.flip_h = false
	elif direction == Vector2.DOWN:
		sprite.play("front")
		sprite.flip_h = false
	elif direction == Vector2.LEFT:
		sprite.play("walk")
		sprite.flip_h = true
	elif direction == Vector2.RIGHT:
		sprite.play("walk")
		sprite.flip_h = false
		
func _on_platform_detector_area_entered(area: Area2D) -> void:
	if "velocity" in area:
		current_platform = area
		if not is_moving:
			target_position.y = area.global_position.y

func _on_platform_detector_area_exited(area: Area2D) -> void:
	if current_platform == area:
		current_platform = null

func die() -> void:
	is_moving = false
	set_physics_process(false)
	current_platform = null
	
	if sprite.sprite_frames.has_animation("die"):
		sprite.play("die")
		await sprite.animation_finished
	else:
		await get_tree().create_timer(0.5).timeout
	
	position = respawn_position
	target_position = respawn_position

	sprite.play("idle")
	set_physics_process(true)

func _on_boundary_body_entered(body: Node2D) -> void:
	if body is Player:
		sprite.play("die")
		body.die()
