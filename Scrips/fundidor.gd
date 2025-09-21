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


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		var musica = $"../Saul"
		var puerta = $Door
		musica.stop()
		puerta.play()
		var tween = get_tree().create_tween()
		tween.tween_property(fade_rect, "modulate:a", 1.0, 1.0) # 1 seg de duración
		# Usamos await para esperar a que termine
		await tween.finished
		await get_tree().create_timer(1.0).timeout
		get_tree().change_scene_to_file("res://Ecenas/Bar.tscn")


func _on_dialogue_box_termine() -> void:
	ConfigManager.moverse=false
	await get_tree().create_timer(1.5).timeout
	var tween = get_tree().create_tween()
	tween.tween_property(fade_rect, "modulate:a", 1.0, 3.0) # 1 seg de duración
	# Usamos await para esperar a que termine
	await tween.finished
	get_tree().change_scene_to_file("res://Ecenas/pokemon.tscn")

func degradado()-> void:
	var tween = get_tree().create_tween()
	tween.tween_property(fade_rect, "modulate:a", 1.0, 2.6)
func agradado()-> void:
	var tween = get_tree().create_tween()
	tween.tween_property(fade_rect, "modulate:a", 0.0, 3.0)
