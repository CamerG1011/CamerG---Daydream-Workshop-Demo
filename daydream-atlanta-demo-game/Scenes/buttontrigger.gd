extends Area2D

@export var bridge_node_path: NodePath
var bridge

func _ready():
	bridge = get_node(bridge_node_path)

func _on_body_entered(body):
	if "Player" in body.name:
		var sprite = bridge.get_node("Sprite2D")
		var shape = bridge.get_node("CollisionShape2D")

		# Set visual transparency (0.0–1.0)
		sprite.modulate.a = 255

		# Reassign shape to force physics update
		var original_shape = shape.shape
		shape.shape = null
		await get_tree().process_frame
		shape.shape = original_shape
		shape.disabled = false

		print("Bridge collision enabled:", !shape.disabled)

func _on_body_exited(body):
	if "Player" in body.name:
		var sprite = bridge.get_node("Sprite2D")
		var shape = bridge.get_node("CollisionShape2D")

		sprite.modulate.a = 50

		# Disable the shape normally
		shape.disabled = true
		print("Bridge collision disabled:", shape.disabled)
