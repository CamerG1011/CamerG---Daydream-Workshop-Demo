extends Node2D

func _on_body_entered(body: Node2D) -> void:
	if "Player" in body.name:
		print("someone died")
		if body.name == "Player1":
			GameManager.player1_dead = true
			GameManager.check_end_condition()
			
			body.hide()
		elif body.name == "Player2":
			GameManager.player2_dead = true
			GameManager.check_end_condition()
			
			body.hide()
