extends Area2D

# Whether the button is pressed
var is_pressed: bool = false

# Called when another body enters the button area
func _on_Button_body_entered(body):
	if body.name == "Player":
		is_pressed = true
		$AnimatedSprite2D.play("enabled")
		print("Button pressed!")
		# You can emit a signal here to open a door, etc.
