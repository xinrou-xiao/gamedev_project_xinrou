# CrouchStrategy.gd
extends MovementStrategy
class_name CrouchStrategy

var is_idle = false

func handle_movement(player: CharacterBody2D, delta: float, speed: int) -> void:
	if Input.is_action_pressed("right"):
		player.velocity.x = speed
		player.theft.flip_h = false
	elif Input.is_action_pressed("left"):
		player.velocity.x = -speed
		player.theft.flip_h = true
	else:
		is_idle = true
		player.velocity.x = 0

func play_animation(player: CharacterBody2D) -> void:
	if is_idle:
		player.theft.play("crouch_idle")
		player.crouch_step.stop()
	else:
		player.theft.play("crouch")
		if not player.crouch_step.playing:
			player.crouch_step.play()
		
		
func handle_flashlight(player: CharacterBody2D) -> void:
	player.flash_light.position.y = 35
