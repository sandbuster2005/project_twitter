extends Node

var Player_health_min = 0
var Player_health_max = 100
var Player_health = 100

func _on_health_update(health, healthMax, healthMin):
	Player_health = health
	Player_health_max = healthMax
	Player_health_min = healthMin
	
