extends Button


func _on_pressed() -> void:
	var sonidoFinal = $"../chao"
	sonidoFinal.play()
	


func _on_chao_finished() -> void:
	get_tree().quit()
