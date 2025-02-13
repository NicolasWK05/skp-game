extends Area2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var pickup_sound: AudioStreamPlayer2D = $PickupSound


func _on_body_entered(body: Node2D) -> void:
	
	if body.name == "Player1":
		GameManager.add_point1()
	elif body.name == "Player2":
		GameManager.add_point2()
	
	PickupSound.play()

	animation_player.play("Pickup")
