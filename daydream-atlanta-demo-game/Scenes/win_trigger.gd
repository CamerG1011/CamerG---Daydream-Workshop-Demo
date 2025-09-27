extends Node2D

func _on_body_entered(body: Node2D) -> void:
	if "Player" in body.name:
		print("someone won")
		if body.name == "Player1":
			GameManager.player1_won = true
			GameManager.check_end_condition()
		elif body.name == "Player2":
			GameManager.player2_won = true
			GameManager.check_end_condition()
