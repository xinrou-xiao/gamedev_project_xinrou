extends NPCState
class_name WanderState

func physics_process(delta: float):
	npc.ray_cast.enabled = true
	handle_gravity(delta)
	handle_movement(delta)
	handle_animation()
	change_direction()
	look_for_player()

func handle_gravity(delta: float):
	if not npc.is_on_floor():
		npc.velocity.y = npc.gravity * delta

func handle_movement(delta: float):
	npc.velocity = npc.velocity.move_toward(npc.direction * npc.SPEED, npc.ACCELERATION * delta)
	npc.move_and_slide()

func handle_animation():
	npc.sprite.play("walk")

func change_direction():
	if npc.sprite.flip_h:
		if npc.position.x >= npc.left_bounds.x:
			npc.direction = Vector2(-1, 0)
		else:
			npc.sprite.flip_h = false
			npc.ray_cast.target_position = Vector2(npc.NORMAL_RAY_LENGTH, 0)
	else:
		if npc.position.x <= npc.right_bounds.x:
			npc.direction = Vector2(1, 0)
		else:
			npc.sprite.flip_h = true
			npc.ray_cast.target_position = Vector2(-npc.NORMAL_RAY_LENGTH, 0)

func look_for_player():
	if npc.ray_cast.is_colliding():
		var collider = npc.ray_cast.get_collider()
		if collider.is_in_group("player") and collider.is_in_group("outside_player"):
			npc.change_state(ChaseState.new(npc))
