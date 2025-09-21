extends Node2D
@onready var player =$Personaje
@onready var guitarra =$guitarra
@onready var area = $guitarra/Area2D
func _ready() -> void:
	area.monitoring = false
	player.position = Vector2(0,60)
	guitarra.position = Vector2(137,-58)
	guitarra.rotate(0)
	await get_tree().create_timer(0.5).timeout
	area.monitoring = true
	
