extends Control

@onready var bar = $ProgressBar
@onready var timer = $Timer
@onready var duration = 1
var resume

func _ready() -> void:
	bar.value = bar.max_value
	
func start_resume_timer(value: int):
	if timer.is_stopped():
		timer.start(duration)
