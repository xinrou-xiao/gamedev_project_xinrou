extends Control

signal press_start

func _on_start_pressed() -> void:
	var main = load("res://scenes/main.tscn")
	get_tree().change_scene_to_packed(main)
