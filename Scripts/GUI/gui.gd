extends Control

signal restart

func _on_restart_button_pressed() -> void:
	restart.emit()
	get_tree().change_scene_to_file("res://Scenes/Levels/test_level.tscn")
