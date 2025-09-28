extends Node

var player1_dead = false
var player2_dead = false

var player1_won = false
var player2_won = false

# Add your stages in order here
var stages = [
	"res://Scenes/Stage1.tscn",
	"res://Scenes/Stage2.tscn",
	"res://Stage3.tscn",
	"res://Stage4.tscn",
	"res://sTAGE5.tscn",
	
	# Add more stages as needed
]

var current_stage_index = 0  # starts at Stage1

func reset():
	player1_dead = false
	player2_dead = false
	player1_won = false
	player2_won = false

func change_scene_by_index(index: int) -> void:
	if index >= 0 and index < stages.size():
		current_stage_index = index
		FadeLayer.fade_to_scene(stages[index])
	else:
		print("Stage index out of bounds:", index)

func change_to_next_stage() -> void:
	var next_index = current_stage_index + 1
	if next_index < stages.size():
		change_scene_by_index(next_index)
	else:
		print("No more stages! Restarting last stage...")
		# Or do something else (like go to main menu)
		change_scene_by_index(current_stage_index)

# Check if exactly one player died and one player won
func check_end_condition() -> void:
	print("CHECKING")
	var one_died = player1_dead != player2_dead
	var one_won = player1_won != player2_won
	var both_dead = player1_dead and player2_dead

	if both_dead:
		print("Both players died! Restarting scene...")
		reset()
		get_tree().reload_current_scene()
		return
	
	if one_died and one_won:
		print("End condition met! Starting end sequence...")
		reset()
		var audio_control = get_tree().current_scene.get_node("Control")
		
		if audio_control:
			await audio_control.trigger_second_sequence()
			
			# After audio finishes, go to next stage
			change_to_next_stage()
		else:
			print("AudioControl node not found in current scene!")
