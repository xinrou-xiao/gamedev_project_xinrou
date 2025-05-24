extends CharacterBody2D

const RUN_SPEED = 500
const WALK_SPEED = 250
const CROUCH_SPEED = 100
const GRAVITY = 60
const JUMPFORCE = -1000
const RUN_REDUCE_SP_PER_SECOND = 100
const WALK_RESUME_SP_PER_SECOND = 30
const CROUCH_RESUME_SP_PER_SECOND = 100

@onready var e_prompt = $CanvasModulate/hint
@onready var theft = $Sprite2D
@onready var flash_light = $Flashlight
@onready var collision = $CollisionShape2D
@onready var walk_step = $WalkStep
@onready var crouch_step = $CrouchStep
@onready var sp = $TextureProgressBar

var in_standing = true
var money = 0
var skip_physics_process = false
var movement_strategy: MovementStrategy = null
var speed = WALK_SPEED

func _ready() -> void:
	add_to_group("player")
	add_to_group("outside_player")
	Global.player = self
	sp.value = sp.max_value

func _physics_process(delta):
	if not self.visible or skip_physics_process:
		sp.value = sp.max_value
		return
	
	var current_sp = sp.value
	speed = WALK_SPEED
	
	if current_sp == sp.max_value:
		sp.visible = false
	else:
		sp.visible = true
	
	if current_sp > 1:
		if Input.is_action_pressed("run"):
			speed = RUN_SPEED
			if Input.is_action_pressed("left") or Input.is_action_pressed("right"):
				current_sp -= delta * RUN_REDUCE_SP_PER_SECOND
			else:
				current_sp += delta * RUN_REDUCE_SP_PER_SECOND

			walk_step.pitch_scale = 2
			walk_step.volume_db = 3
			
	if !is_on_floor():
		movement_strategy = AirborneStrategy.new()
	elif Input.is_action_pressed("crouch"):
		speed = CROUCH_SPEED
		current_sp += delta * CROUCH_RESUME_SP_PER_SECOND
		movement_strategy = CrouchStrategy.new()
	else:
		if speed == WALK_SPEED:
			walk_step.pitch_scale = 1.57
			walk_step.volume_db = 1
			current_sp += delta * WALK_RESUME_SP_PER_SECOND
		movement_strategy = MoveStrategy.new()
	
	sp.value = clamp(current_sp, sp.min_value, sp.max_value)
	
	movement_strategy.handle_movement(self, delta, speed)
	movement_strategy.handle_flashlight(self)
	movement_strategy.play_animation(self)
	
	if theft.flip_h:
		flash_light.position.x = -128
		sp.position.x = -77
	else:
		flash_light.position.x = 128
		sp.position.x = 77
	
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

func get_player_state():
	if not (Input.is_action_pressed("left") or Input.is_action_pressed("right")):
		return "idle"
	elif speed == WALK_SPEED:
		return "walk"
	elif speed == RUN_SPEED:
		return "run"
	else:
		return "crouch"
