# CrouchStrategy.gd
extends MovementStrategy
class_name CrouchStrategy

var is_idle = false

func handle_movement(player: CharacterBody2D, delta: float) -> void:
	if Input.is_action_pressed("right"):
		player.velocity.x = player.CROUCH_SPEED
		player.theft.flip_h = false
	elif Input.is_action_pressed("left"):
		player.velocity.x = -player.CROUCH_SPEED
		player.theft.flip_h = true
	else:
		is_idle = true
		player.velocity.x = 0

func play_animation(player: CharacterBody2D) -> void:
	if is_idle:
		player.theft.play("crouch_idle")
	else:
		player.theft.play("crouch")
		
func handle_flashlight(player: CharacterBody2D) -> void:
	player.flash_light.position.y = 35
