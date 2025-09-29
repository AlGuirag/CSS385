extends CanvasLayer

func _input(event):
	if event.is_action_pressed("pause") && not %GameOver.visible:
		if get_tree().paused:
			%Pause.visible = false
			get_tree().paused = false
		else:
			%Pause.visible = true
			get_tree().paused = true
