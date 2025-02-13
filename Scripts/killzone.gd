extends Area2D

@onready var timer: Timer = $Timer

func _on_body_entered(body: Node2D) -> void:
	
	if body.name == "Player1":
		GameManager.died1()  # Direct access to global GameManager
		print("Player 1 died!") # Debug
	elif body.name == "Player2":
		GameManager.died2()
		print("Player 2 died!") # Debug
		
	body.get_node("CollisionShape2D").set_deferred("disabled", true)  # Deactivate collisions
	body.hide() # Hide the player
	body.set_process(false)  # Stop processing inputs
	body.set_physics_process(false)  # Stop physics interactions
	


func _on_timer_timeout() -> void:
	get_tree().reload_current_scene()
