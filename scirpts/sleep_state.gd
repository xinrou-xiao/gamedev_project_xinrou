extends NPCState
class_name SleepState

var is_in_area: bool = false
var player: CharacterBody2D = null
const RUN_DEVIDENT = 10
const WALK_DEVIDENT = 50
const CROUCH_DEVIDENT = 1000
const IDLE_DEVIDENT = 1000000

func physics_process(delta: float):
	npc.sprite.play("sleep")
	npc.ray_cast.enabled = false
	if is_in_area:
		on_sound_heard()
	
func get_into_area(body: Node2D):
	if body.is_in_group("player") and body.is_in_group("outside_player"):
		is_in_area = true
		
func get_out_of_area(body: Node2D):
	if body.is_in_group("player") and body.is_in_group("outside_player"):
		is_in_area = false

func on_sound_heard():
		var listen_base_area = npc.sound_area.shape.size.x / 2
		var distance = abs(npc.position.x - npc.player.position.x)
		npc.HEARD_CHANCE = listen_base_area / distance / get_divident()
		
		if randf() <= npc.HEARD_CHANCE:
			npc.position.y = 290
			npc.change_state(ChaseState.new(npc))
			
func get_divident():
	var state = npc.player.get_player_state()
	if state == "idle":
		return IDLE_DEVIDENT
	elif state == "run":
		return RUN_DEVIDENT
	elif state == "walk":
		return WALK_DEVIDENT
	else:
		return CROUCH_DEVIDENT
