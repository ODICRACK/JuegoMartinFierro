extends Button


func _on_pressed() -> void:
	var rng = RandomNumberGenerator.new()
	rng.randomize()  # inicializa la semilla

	var numero = rng.randi_range(0, 1)  # devuelve 0 o 1
	if numero == 0:
		OS.shell_open("https://www.youtube.com/watch?v=dQw4w9WgXcQ&list=RDdQw4w9WgXcQ&start_radio=1")
	else:
		get_tree().change_scene_to_file("res://Ecenas/troleo.tscn")
