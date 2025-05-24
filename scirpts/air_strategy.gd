
extends MovementStrategy

class_name AirborneStrategy

func handle_movement(player: CharacterBody2D, delta: float, speed: int) -> void:
	if Input.is_action_pressed("right"):
		player.velocity.x = speed
		player.theft.flip_h = false
	elif Input.is_action_pressed("left"):
		player.velocity.x = -speed
		player.theft.flip_h = true
		
	player.velocity.y = player.velocity.y + player.GRAVITY

func play_animation(player: CharacterBody2D) -> void:
	player.theft.play("air")

func handle_flashlight(player: CharacterBody2D) -> void:
	player.flash_light.position.y = -35
