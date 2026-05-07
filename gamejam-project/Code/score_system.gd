extends Control

var current_score : int = 999

# @onready finds the nodes in the scene after it loads
@onready var score_label = $ScoreLabel
@onready var score_timer = $ScoreTimer

func _ready():
	# Display the initial score immediately
	update_score_display()
	$ScoreLabel.text = "Final Score: " + str(GameManager.final_score)
	# Connects the timer's signal via code so it triggers the function below
	if not score_timer.timeout.is_connected(_on_score_timer_timeout):
		score_timer.timeout.connect(_on_score_timer_timeout)

func _on_score_timer_timeout():
	current_score -= 1
	update_score_display()
	
	if current_score <= 0:
		trigger_game_over()

func update_score_display():
	score_label.text = "Score: " + str(current_score)
	
func reset_game():
	current_score = 999

func start_scoring():
	current_score = 999
	update_score_display()
	score_timer.start()

func trigger_game_over():
	score_timer.stop()
	print("Game Over! Score reached 0.")
