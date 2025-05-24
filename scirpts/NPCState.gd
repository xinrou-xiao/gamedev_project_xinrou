extends RefCounted
class_name NPCState

var npc: NPC

func _init(npc):
	self.npc = npc

func physics_process(delta: float):
	pass

func on_timer_timeout():
	pass

func get_into_area(body: Node2D):
	pass
	
func get_out_of_area(body: Node2D):
	pass
