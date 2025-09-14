extends VBoxContainer

@onready var slider_music = $Musica
@onready var slider_sfx = $Efectos

func _ready():
	# Inicializar sliders con valores actuales de los buses
	slider_music.value = ConfigManager.get_volume_music_db()
	slider_sfx.value = ConfigManager.get_volume_sfx_db()
	# Conectar señales
	#slider_music.value_changed.connect(_on_music_volume_changed)
	#slider_sfx.value_changed.connect(_on_sfx_volume_changed)

func _on_music_volume_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), value)
	ConfigManager.set_volume_music_db(slider_music.value)

func _on_sfx_volume_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), value)
	ConfigManager.set_volume_sfx_db(slider_sfx.value)
