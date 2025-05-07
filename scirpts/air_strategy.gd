
extends MovementStrategy

class_name AirborneStrategy

func handle_movement(player: CharacterBody2D, delta: float) -> void:
	if Input.is_action_pressed("right"):
		player.velocity.x = player.SPEED
		player.theft.flip_h = false
	elif Input.is_action_pressed("left"):
		player.velocity.x = -player.SPEED
		player.theft.flip_h = true
		
	player.velocity.y = player.velocity.y + player.GRAVITY

func play_animation(player: CharacterBody2D) -> void:
	player.theft.play("air")

func handle_flashlight(player: CharacterBody2D) -> void:
	player.flash_light.position.y = -35
