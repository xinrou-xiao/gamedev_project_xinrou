extends MovementStrategy
class_name MoveStrategy

var is_idle = false

func handle_movement(player: CharacterBody2D, delta: float, speed: int) -> void:
	if Input.is_action_pressed("right"):
		player.velocity.x = speed
		player.theft.flip_h = false
	elif Input.is_action_pressed("left"):
		player.velocity.x = -speed
		player.theft.flip_h = true
	else:
		is_idle =true
		player.velocity.x = 0

func play_animation(player: CharacterBody2D) -> void:
	if is_idle:
		player.theft.play("idle")
		player.walk_step.stop()
	else:
		player.theft.play("walk")
		if not player.walk_step.playing:
			player.walk_step.play()
		
func handle_flashlight(player: CharacterBody2D) -> void:
	player.flash_light.position.y = 0
