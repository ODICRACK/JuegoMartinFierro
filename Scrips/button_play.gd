extends Button
@onready var sonido2 = $"../chao"

func _on_pressed() -> void:
	load("res://Ecenas/Stardew.tscn") as PackedScene
	sonido2.play()
