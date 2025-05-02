class_name Game extends Node

@export var load_level : PackedScene = preload("res://Scenes/Levels/test_level.tscn")
@export var load_gui : PackedScene = preload("res://Scenes/GUI/GUI.tscn")

func _ready() -> void:
	_change_level()

func _change_level():
	var level = load_level.instantiate()
	var gui = load_gui.instantiate()
	add_child(level)
	add_child(gui)
	
