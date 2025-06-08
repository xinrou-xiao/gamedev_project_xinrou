extends CharacterBody2D

class_name NPC

@export var SPEED: int = 100
@export var CHASE_SPEED: int = 500
@export var ACCELERATION: int = 300
@export var HEARD_CHANCE: float = 0.01

@onready var sprite = $AnimatedSprite2D
@onready var ray_cast = $AnimatedSprite2D/RayCast2D
@onready var timer = $Timer
@onready var sound_area = $SoundArea/CollisionShape2D

var gravity = 100
var direction: Vector2
var right_bounds: Vector2
var left_bounds: Vector2
var ray_cast_length = 200
var player: CharacterBody2D

const NORMAL_RAY_LENGTH = 200
const CHASE_RAY_LENGTH = 400

var state: NPCState
var current_state = "SLEEP"

func _ready() -> void:
	left_bounds = self.position + Vector2(max(-NORMAL_RAY_LENGTH, 0), 0)
	right_bounds = self.position + Vector2(NORMAL_RAY_LENGTH * 2, 0)
	state = SleepState.new(self)

func _physics_process(delta: float) -> void:
	if player == null:
		player = Global.player
	state.physics_process(delta)

func change_state(new_state: NPCState):
	state = new_state
	current_state = new_state.name

func _on_timer_timeout() -> void:
	state.on_timer_timeout()

func _on_sound_area_body_entered(body: Node2D) -> void:
	state.get_into_area(body)

func _on_sound_area_body_exited(body: Node2D) -> void:
	state.get_out_of_area(body)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and body.is_in_group("outside_player"):
		get_tree().change_scene_to_file("res://scenes/game over.tscn")
