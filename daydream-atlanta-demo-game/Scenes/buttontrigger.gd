extends Node2D

var is_pressed: bool = false

func _on_body_entered(body):
	if "Player" in body.name:
		is_pressed = true
		print("Button Pressed!")

func _on_body_exited(body):
	if "Player" in body.name:
		is_pressed = false
		print("Button Released!")
