extends Button
@onready var sonido2 = $"../chao"

func _on_pressed() -> void:
	sonido2.play()
