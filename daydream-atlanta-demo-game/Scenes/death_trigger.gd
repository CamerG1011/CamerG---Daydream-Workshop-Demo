extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if "Player" in body.name:
		print("someone died")
		if body.name == "Player1":
			GameManager.player1_dead = true
			GameManager.check_end_condition()
		elif body.name == "Player2":
			GameManager.player2_dead = true
			GameManager.check_end_condition()
		
		# Move the player far off-screen
		body.global_position = Vector2(100000, 100000)
