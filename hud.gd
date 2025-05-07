extends CanvasLayer

var money = 0
@onready var theft = $"../Theft"
@onready var hint_Label = $Hint
@onready var money_label = $Moneys

func _ready():
	update_money()
	
func _physics_process(delta: float) -> void:
	if theft.current_interactable != null:
		hint_Label.text = "[E]"
	else:
		hint_Label.text = ""
	
func update_money():
	money_label.text = "{money}".format({"money": money})

func _on_money_stack_collected() -> void:
	money = money + 10
	update_money()
