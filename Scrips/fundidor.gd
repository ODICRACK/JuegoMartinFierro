extends CanvasLayer
@onready var fade_rect = $ColorRect

func _on_fade_finished():
	print("se terminó el fundido")
	# Acá podés poner la acción que quieras (cambio de escena, etc.)
	get_tree().change_scene_to_file("res://Ecenas/Stardew.tscn")
	
func _on_buttonquit_pressed() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(fade_rect, "modulate:a", 1.0, 1.0) # 1 seg de duración
	# Usamos await para esperar a que termine
	await tween.finished
	


func _on_button_play_pressed() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(fade_rect, "modulate:a", 1.0, 5.0) # 1 seg de duración
	# Usamos await para esperar a que termine
	await tween.finished
	_on_fade_finished()
