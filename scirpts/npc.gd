extends CharacterBody2D

class_name NPC

@export var SPEED: int = 100
@export var CHASE_SPEED: int = 500
@export var ACCELERATION: int = 300

@onready var sprite = $AnimatedSprite2D
@onready var ray_cast = $AnimatedSprite2D/RayCast2D
@onready var timer = $Timer

var gravity = 100
var direction: Vector2
var right_bounds: Vector2
var left_bounds: Vector2
var ray_cast_lenth = 300
var player: CharacterBody2D

enum States{
	WANDER,
	CHASE
}
var current_state = States.WANDER

func _ready() -> void:
	left_bounds = self.position + Vector2(-ray_cast_lenth, 0)
	right_bounds = self.position + Vector2(ray_cast_lenth, 0)
	
func _physics_process(delta: float) -> void:
	if player == null:
		player = Global.player
	handle_gravity(delta)
	handle_movement(delta)
	handle_animation()
	change_direction()
	look_for_player()
	
func look_for_player():
	if ray_cast.is_colliding():
		var collier = ray_cast.get_collider()
		if collier.is_in_group("player") and collier.is_in_group("outside_player"):
			chase_player()
		elif current_state == States.CHASE:
			stop_chase()
	elif current_state == States.CHASE:
			stop_chase()
			
func chase_player():
	timer.stop()
	current_state = States.CHASE
	
func stop_chase():
	if timer.time_left <= 0:
		timer.start()
		
func handle_movement(delta: float):
	if current_state == States.WANDER:
		velocity = velocity.move_toward(direction * SPEED, ACCELERATION * delta)
	else:
		velocity = velocity.move_toward(direction * CHASE_SPEED, ACCELERATION * delta)
		
	move_and_slide()
	
func handle_animation():
	if current_state == States.WANDER:
		sprite.play("walk")
	else:
		sprite.play("chase")
	
func change_direction():
	if current_state == States.WANDER:
		if sprite.flip_h:
			if self.position.x >= left_bounds.x:
				direction = Vector2(-1, 0)
			else:
				sprite.flip_h = false
				ray_cast.target_position = Vector2(ray_cast_lenth, 0)
		else:
			if self.position.x <= right_bounds.x:
				direction = Vector2(1, 0)
			else:
				sprite.flip_h = true
				ray_cast.target_position = Vector2(-ray_cast_lenth, 0)		
	elif player.is_in_group("outside_player"):
		direction = (player.position - self.position).normalized()
		direction = sign(direction)
		if direction.x == 1:
			sprite.flip_h = false
			ray_cast.target_position = Vector2(ray_cast_lenth, 0)
		else:
			sprite.flip_h = true
			ray_cast.target_position = Vector2(-ray_cast_lenth, 0)

func handle_gravity(delta: float):
	if not is_on_floor():
		velocity.y = gravity * delta

func _on_timer_timeout() -> void:
	current_state = States.WANDER
