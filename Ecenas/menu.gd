extends Control


func _on_button_options_pressed() -> void:
	var box = $"VBoxContainer"
	var boxSecundary = $"opciones"
	box.visible = !box.visible
	boxSecundary.visible = !boxSecundary.visible
	
