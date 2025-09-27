extends Node2D

@onready var fade_rect = $FadeLayer/ColorRect

func _ready():
	fade_rect.modulate.a = 0.0  # start fully transparent

func fade_to_scene(new_scene_path: String) -> void:
	print("fading")
	var tween = create_tween()
	tween.tween_property(fade_rect, "modulate:a", 1.0, 1.0)  # fade out
	await tween.finished

	get_tree().change_scene_to_file(new_scene_path)

	var tween_in = create_tween()
	tween_in.tween_property(fade_rect, "modulate:a", 0.0, 1.0)  # fade in
	await tween_in.finished
