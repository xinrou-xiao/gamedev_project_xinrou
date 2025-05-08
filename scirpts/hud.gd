extends CanvasLayer

var money_count = 0
@onready var money_label = $Money
@onready var theft = $"../Theft"
@onready var hint = $Hint

func _on_money_collected() -> void:
	money_count = money_count + 10
	update_money_count()
	
func update_money_count():
	money_label.text = str(money_count)
	
func _process(delta: float) -> void:
	if InteractableFacade.current_target == null:
		hide_hint()
	else:
		show_hint()
	
func show_hint():
	hint.text = "[E]"

func hide_hint():
	hint.text = ""
