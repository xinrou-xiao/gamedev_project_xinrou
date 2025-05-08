extends CharacterBody2D

const SPEED = 500
const CROUCH_SPEED = 250
const GRAVITY = 60
const JUMPFORCE = -1000

@onready var e_prompt = $CanvasModulate/hint
@onready var theft = $Sprite2D
@onready var flash_light = $Flashlight

var in_standing = true
var money = 0
var skip_physics_process = false
var movement_strategy: MovementStrategy = null

func _ready() -> void:
	add_to_group("player")

func _physics_process(delta):
	if skip_physics_process:
		return
		
	if Input.is_action_pressed("crouch"):
		movement_strategy = CrouchStrategy.new()
	elif !is_on_floor():
		movement_strategy = AirborneStrategy.new()
	else:
		movement_strategy = WalkStrategy.new()
	
	movement_strategy.handle_movement(self,  delta)
	movement_strategy.handle_flashlight(self)
	movement_strategy.play_animation(self)
	
	if theft.flip_h:
		flash_light.position.x = -128
	else:
		flash_light.position.x = 128
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMPFORCE
	
	move_and_slide()
	velocity.x = lerp(velocity.x, 0.0, 0.9)
		
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact"):
		InteractableFacade.interact(self)

func addMoney(amount: int):
	money = money + amount

func play_grab():
	if theft.animation == "grab":
		return
	skip_physics_process = true
	theft.play("grab")


func _on_sprite_2d_animation_finished() -> void:
	if theft.animation == "grab":
		skip_physics_process = false
		theft.play("idle")
