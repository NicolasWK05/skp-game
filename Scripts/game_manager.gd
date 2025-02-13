extends Node

@onready var end_screen_position = Vector2(-8859, -2739)
@onready var end_screen_zoom = Vector2(1.5, 1.5)
var player1_camera: Camera2D
var player2_camera: Camera2D

var score1 = 0
var score2 = 0

var is_alive1: bool = true
var is_alive2: bool = true

func _ready():
	# Find the required nodes dynamically
	player1_camera = get_tree().get_root().find_child("Player1Camera", true, false)
	player2_camera = get_tree().get_root().find_child("Player2Camera", true, false)

	# Debugging: Check if we found everything
	if player1_camera:
		print("✅ Player1 Camera Found: ", player1_camera)
	else:
		print("❌ ERROR: Player1 Camera not found!")

	if player2_camera:
		print("✅ Player2 Camera Found: ", player2_camera)
	else:
		print("❌ ERROR: Player2 Camera not found!")

# Point calculations
func add_point1():
	score1 += 1
	print("score1 is now " + str(score1))
	#score_label.text = "Din score er " + str(score)

func add_point2():
	score2 += 1
	print("score2 is now " + str(score2))
	#score_label.text = "Din score er " + str(score)
	
# Player stuff

func died1():
	is_alive1 = false
	check_game_over()

func died2():
	is_alive2 = false
	check_game_over()

func check_game_over():
	if not is_alive1 and not is_alive2:
		trigger_game_over() 
		print("Both dead lol noobs")

func trigger_game_over():
	var player1_score_label = get_tree().get_root().find_child("Player1Score", true, false)
	var player2_score_label = get_tree().get_root().find_child("Player2Score", true, false)
	var win_lose_label = get_tree().get_root().find_child("WinLose", true, false)
	
	if player1_score_label:
		player1_score_label.text = "Player 1 Score: " + str(score1)
	if player2_score_label:
		player2_score_label.text = "Player 2 Score: " + str(score2)

	# Determine Winner
	if win_lose_label:
		if score1 > score2:
			win_lose_label.text = "Player 1 Wins!"
		elif score2 > score1:
			win_lose_label.text = "Player 2 Wins!"
		else:
			win_lose_label.text = "It's a Tie!"
	
	if player1_camera and player2_camera:
		# Move player cameras to Game Over screen
		player1_camera.global_position = end_screen_position
		player2_camera.global_position = end_screen_position
		# Resize cameras (zoom in)
		player1_camera.zoom = end_screen_zoom
		player2_camera.zoom = end_screen_zoom

	# display_winner()

func reset_references():
	# Find the required nodes dynamically after scene reload
	is_alive1 = true
	is_alive2 = true
	score1 = 0
	score2 = 0
	player1_camera = get_tree().get_root().find_child("Player1Camera", true, false)
	player2_camera = get_tree().get_root().find_child("Player2Camera", true, false)

	# Debugging: Check if we found everything
	if player1_camera:
		print("✅ Player1 Camera Found: ", player1_camera.get_path())
	else:
		print("❌ ERROR: Player1 Camera NOT Found!")

	if player2_camera:
		print("✅ Player2 Camera Found: ", player2_camera.get_path())
	else:
		print("❌ ERROR: Player2 Camera NOT Found!")

func _process(delta):
	if Input.is_action_just_pressed("Reset"):
		print("🔄 Reset button pressed! Restarting game...")
		get_tree().reload_current_scene()
		await get_tree().process_frame
		reset_references()
