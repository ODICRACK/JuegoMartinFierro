extends Control

@onready var button_actions = {
	"Arriba": $"opciones de lado/contenedorOpciones/teclas/tecla3/Arriba",
	"Abajo": $"opciones de lado/contenedorOpciones/teclas/tecla4/Abajo",
	"Izq": $"opciones de lado/contenedorOpciones/teclas/tecla/Izquierda",
	"Dere": $"opciones de lado/contenedorOpciones/teclas/tecla2/Derecha",
	"Tirar": $"opciones de lado/contenedorOpciones/teclas/tecla5/Tirar"
}
var waiting_for_key: String = ""

func _ready():
	# Conectar todos los botones a la misma función
	for action_name in button_actions.keys():
		button_actions[action_name].pressed.connect(func(): _on_button_pressed(action_name))
		# Inicializar texto con la tecla actual
		button_actions[action_name].text = ConfigManager.get_control(action_name)
		
func _on_button_pressed(action_name: String) -> void:
	waiting_for_key = action_name
	button_actions[action_name].text = "..." # feedback visual

func _input(event: InputEvent) -> void:
	if waiting_for_key == "":
		return

	if event is InputEventKey and event.pressed and not event.echo:
		var keycode = event.physical_keycode
		if keycode == 0:
			return

		var key_string = OS.get_keycode_string(keycode).to_upper()

		# Actualizar botón y guardar en JSON
		button_actions[waiting_for_key].text = key_string
		ConfigManager.set_control(waiting_for_key, key_string)

		# Reset
		waiting_for_key = ""

func _replace_action_key(action_name: String, new_keycode: Key) -> void:
	for ev in InputMap.action_get_events(action_name):
		InputMap.action_erase_event(action_name, ev)

	var new_event := InputEventKey.new()
	new_event.physical_keycode = new_keycode
	InputMap.action_add_event(action_name, new_event)

func _get_first_key_for_action(action_name: String) -> String:
	var events = InputMap.action_get_events(action_name)
	if events.size() > 0 and events[0] is InputEventKey:
		return OS.get_keycode_string(events[0].physical_keycode).to_upper()
	return "NONE"
