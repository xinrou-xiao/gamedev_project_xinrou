extends CharacterBody2D

@onready var ray_cast = $AnimatedSprite2D/RayCast2D
@onready var sprite = $AnimatedSprite2D
const SPEED: int =  250
const CHASE_SPEED: int = 500
const ACCELERATION: int = 300
const GRAVITY = 500

var direction: Vector2
var player: CharacterBody2D = null

enum States{ 
	NORMAL,
	CHASE
}
var current_state = States.NORMAL

func _ready() -> void:
	await get_tree().process_frame
	player = get_tree().get_nodes_in_group("player")[0]

func _physics_process(delta: float) -> void:
	move(delta)
	handle_gravity(delta)
	change_direction()
	look_for_player()
	
func look_for_player():
	if ray_cast.is_colliding():
		if ray_cast.get_collider() is CharacterBody2D:
			chase_player()
		elif current_state == States.CHASE:
			stop_chase()
	elif current_state == States.CHASE:
		stop_chase()

func chase_player():
	current_state = States.CHASE
	
func stop_chase():
	current_state = States.NORMAL
	
func move(delta:float):
	if current_state == States.NORMAL:
		velocity = velocity.move_toward(direction * SPEED, ACCELERATION * delta)
	else:
		velocity = velocity.move_toward(direction * CHASE_SPEED, ACCELERATION * delta)
	move_and_slide()
	
func change_direction():
	if current_state == States.CHASE:
		direction = (player.position - self.position).normalized()
		direction = sign(direction)
		if direction.x == 1:
			sprite.flip_h = false
			ray_cast.target_position = Vector2(125, 0)
		else :
			sprite.flip_h = true
			ray_cast.target_position = Vector2(-125, 0)
			
func handle_gravity(delta: float):
	if not is_on_floor():
		velocity.y = GRAVITY * delta

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		get_tree().change_scene_to_file("res://scenes/game over.tscn")
		
