extends NPCState
class_name ChaseState

func _init(npc):
	super(npc)
	npc.timer.stop()

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
	npc.velocity = npc.velocity.move_toward(npc.direction * npc.CHASE_SPEED, npc.ACCELERATION * delta)
	npc.move_and_slide()

func handle_animation():
	npc.sprite.play("chase")

func change_direction():
	if npc.player.is_in_group("outside_player"):
		npc.direction = (npc.player.position - npc.position).normalized()
		npc.direction = sign(npc.direction)
		if npc.direction.x == 1:
			npc.sprite.flip_h = false
			npc.ray_cast.target_position = Vector2(npc.CHASE_RAY_LENGTH, 0)
		else:
			npc.sprite.flip_h = true
			npc.ray_cast.target_position = Vector2(-npc.CHASE_RAY_LENGTH, 0)

func look_for_player():
	if npc.timer.time_left <= 0:
		if npc.ray_cast.is_colliding():
			var collider = npc.ray_cast.get_collider()
			if not (collider.is_in_group("player") and collider.is_in_group("outside_player")):
				npc.timer.start()
		else:
			npc.timer.start()

func on_timer_timeout():
	npc.change_state(WanderState.new(npc))
	
