extends Node2D

# export makes variable editable in inspector
@export var initial_spawns: int = 5

@onready var countdown: Timer = %Countdown
@onready var countdown_label: Label = %CountdownLabel

func _ready():
	for i in initial_spawns:
		spawn_mob()
	countdown.start()

func time_left():
	var time_left = countdown.time_left
	var minute = floor(time_left / 60)
	var second = int(time_left) % 60
	return [minute, second]

func _process(delta: float) -> void:
	countdown_label.text = "%02d:%02d" % time_left()

func spawn_mob():
	var new_mob = preload("res://mob.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	new_mob.global_position = %PathFollow2D.global_position
	add_child(new_mob)

func _on_timer_timeout() -> void:
	spawn_mob()

func _on_player_health_depleted() -> void:
	# same as %GameOver.show()
	%GameOver.visible = true
	get_tree().paused = true

func _on_countdown_timeout() -> void:
	%Win.visible = true
	get_tree().paused = true
