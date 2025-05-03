class_name GUI extends CanvasLayer

signal restart


func _on_restart_button_pressed() -> void:
	restart.emit()
