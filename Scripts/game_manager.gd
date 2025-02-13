extends Node

var score = 0
@onready var score_label: Label = $"../Player/Camera2D/ScoreLabel"

func add_point():
	score += 1
	#score_label.text = "Din score er " + str(score)
