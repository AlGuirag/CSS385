extends CharacterBody2D

signal health_depleted

var health = 100

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * 600
	move_and_slide()
	
	if (velocity.length() > 0):
		# $HappyBoo == get_node("HappyBoo")
		# %HappyBoo ignores need to include path (only for this scene)
		%HappyBoo.play_walk_animation()
	else:
		%HappyBoo.play_idle_animation()
		
	const DAMAGE_RATE = 20
	var overlapping_mobs = %HurtBox.get_overlapping_bodies()
	if overlapping_mobs.size() > 0:
		health -= DAMAGE_RATE * overlapping_mobs.size() * delta
		%ProgressBar.value = health
		if health < 100:
			%ProgressBar.show()
		else:
			%ProgressBar.hide()
		if health <= 0.0:
			health_depleted.emit()
