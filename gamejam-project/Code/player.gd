extends CharacterBody2D
class_name Player

@export var tile_size: int = 32
@export var move_speed: float = 0.2
@export var heart_full_tex: Texture2D
@export var heart_empty_tex: Texture2D

var is_moving: bool = false
var target_position: Vector2 = Vector2.ZERO
var current_platform: Area2D = null
var respawn_position: Vector2
var hearts_list : Array[TextureRect] = [] # joni hp
var health = 5 # joni hp

@onready var ray: RayCast2D = $RayCast2D
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

signal goal_reached

func _ready() -> void:
	respawn_position = position
	target_position = position
	var hearts_parent = $Healthbar/HBoxContainer
	for child in hearts_parent.get_children():
		hearts_list.append(child)
	print(hearts_list)

func take_damage(): # joni hp
	if health > 0:
		health -= 1
		if $damage: $damage.play("damaged")
		update_heart_display()
		
	if health <= 0:
		$GameOverSound.play()
		await get_tree().create_timer(1.2).timeout
		get_tree().change_scene_to_file("res://Scenes/game_over.tscn")
	
func update_heart_display():
	if hearts_list.is_empty():
		hearts_list = $CanvasLayer/UI/HBoxContainer.get_children() as Array[TextureRect]
		
	for i in range(hearts_list.size()):
		if i < health:
			hearts_list[i].texture = heart_full_tex
		else:
			hearts_list[i].texture = heart_empty_tex
		
	if health <= 0:
		$GameOverSound.play()
		await get_tree().create_timer(1.1).timeout
		get_tree().change_scene_to_file("res://Scenes/game_over.tscn")


func _physics_process(_delta: float) -> void:	
	ray.force_raycast_update()
	if ray.is_colliding():
		var collider = ray.get_collider()
		if not is_moving and "is_rideable" in collider and collider.is_rideable:
			current_platform = collider
	else:
		if not is_moving:
			current_platform = null
		
	if current_platform:
		var drift = current_platform.velocity * _delta
		global_position += drift
		target_position += drift

	if is_moving:
		position = position.move_toward(target_position, tile_size * (1.0 / move_speed) * _delta)
		if position.distance_to(target_position) < 0.1:
			position = target_position
			is_moving = false
			
			check_goals()
			check_deadzone()
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
	var max_y: float = 896.0

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
	if area.is_in_group("Hazards"):
		die()

func _on_platform_detector_area_exited(_area: Area2D) -> void:
	pass

func check_goals() -> void:
	$PlatformDetector.force_update_transform()
	var overlapping = $PlatformDetector.get_overlapping_areas()
	
	for area in overlapping:
		if area.is_in_group("GoalPods"):
			if not area.is_occupied:
				area.fill_goal()
				reset_to_start()
				goal_reached.emit()
			else:
				die()
			break
			
			
func reset_to_start():
	is_moving = false
	current_platform = null
	position = respawn_position
	target_position = respawn_position
	sprite.play("idle")
			
			
func die() -> void:
	is_moving = false
	set_physics_process(false)
	current_platform = null
	
	take_damage()
	
	if sprite.sprite_frames.has_animation("die"):
		sprite.play("die")
		await sprite.animation_finished
		await get_tree().create_timer(1.2).timeout
	
	position = respawn_position
	target_position = respawn_position

	sprite.play("idle")
	set_physics_process(true)

func check_deadzone() -> void:
	$PlatformDetector.force_update_transform()
	ray.force_raycast_update()
	
	if ray.is_colliding():
		var collider = ray.get_collider()
		if "is_rideable" in collider and collider.is_rideable:
			return

	var overlapping_areas = $PlatformDetector.get_overlapping_areas()
	var in_deadzone = false
	for area in overlapping_areas:
		if area.is_in_group("Deadzone"):
			in_deadzone = true
			break

	if in_deadzone and not is_moving and current_platform == null:
		die()


func _on_boundary_body_entered(body: Node2D) -> void:
	if body is Player:
		die()
