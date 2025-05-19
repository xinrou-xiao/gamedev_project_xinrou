extends CanvasLayer

@onready var money_label = $Money
@onready var theft = $"../Theft"
@onready var hint = $Hint
@onready var cash_sound = $CashSound

func _on_money_collected() -> void:
	cash_sound.play()
	update_money_count()
	
func update_money_count():
	money_label.text = str(Global.money_count)
	
func _process(delta: float) -> void:
	if InteractableFacade.current_target == null:
		hide_hint()
	else:
		show_hint()
	
func show_hint():
	hint.text = "[E]"

func hide_hint():
	hint.text = ""
