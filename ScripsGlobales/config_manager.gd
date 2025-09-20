extends Node
var moverse:bool = true
var config_file_path := "user://config.json"
var settings := {
	"audio": {
		"Music": 0.0,  # Volumen música en dB
		"SFX": 0.0     # Volumen efectos en dB
	},
	"controls": {
		"Arriba": "W",
		"Abajo": "S",
		"Izq": "A",
		"Dere": "D",
		"Tirar": "Q"
	}
}

func _ready() -> void:
	load_config()
	_apply_audio()
	_apply_controls()

# ----------------------
# 🔹 Guardar y cargar JSON
# ----------------------
func save_config() -> void:
	var file := FileAccess.open(config_file_path, FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(settings, "\t"))
		file.close()

func load_config() -> void:
	if not FileAccess.file_exists(config_file_path):
		save_config() # Crear por defecto si no existe
		return
	
	var file := FileAccess.open(config_file_path, FileAccess.READ)
	if file:
		var data = JSON.parse_string(file.get_as_text())
		if typeof(data) == TYPE_DICTIONARY:
			settings = data
		file.close()

# ----------------------
# 🔹 Audio
# ----------------------
func set_volume_music_db(value: float) -> void:
	settings.audio.Music = value
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), value)
	save_config()

func set_volume_sfx_db(value: float) -> void:
	settings.audio.SFX = value
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), value)
	save_config()

func get_volume_music_db() -> float:
	return settings.audio.Music

func get_volume_sfx_db() -> float:
	return settings.audio.SFX

func _apply_audio() -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), settings.audio.Music)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), settings.audio.SFX)

# ----------------------
# 🔹 Controles
# ----------------------
func set_control(action_name: String, key_str: String) -> void:
	settings.controls[action_name] = key_str
	_update_input_map(action_name, key_str)
	save_config()

func get_control(action_name: String) -> String:
	return settings.controls.get(action_name, "")

func _apply_controls() -> void:
	for action_name in settings.controls.keys():
		_update_input_map(action_name, settings.controls[action_name])

func _update_input_map(action_name: String, key_str: String) -> void:
	# Limpiar acción previa
	InputMap.action_erase_events(action_name)

	# Convertir string a keycode
	var ev := InputEventKey.new()
	ev.physical_keycode = OS.find_keycode_from_string(key_str)
	InputMap.action_add_event(action_name, ev)
