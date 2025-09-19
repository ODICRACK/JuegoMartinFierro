extends Control

@onready var text = $text
@onready var Grande = $Control/imagen
@onready var nombre = $Nombre
@onready var sound = $Sans

var dialogos: Array = []
var current_index: int = 0
var typing: bool = false
var skip: bool = false
var cont:int = 0
func _on_npc_dialogo(Nom:String, _cantDialogos:int, _Sprite:Texture2D, SpriteGrande:Texture2D, _Dialogos) -> void:
	visible = true
	Grande.texture = SpriteGrande
	nombre.text = Nom
	dialogos = _Dialogos
	current_index = 0
	_show_dialogo()

func _show_dialogo() -> void:
	if current_index < dialogos.size():
		text.text = ""
		_start_typing(dialogos[current_index])
	else:
		# No hay más diálogos
		visible = false

func _start_typing(linea: String) -> void:
	typing = true
	skip = false
	text.text = ""

	# Lanzamos una corrutina para escribir la línea
	
	call_deferred("_type_line", linea)

func _type_line(linea: String) -> void:
	var palabras = linea.split(" ")
	for palabra in palabras:
		# Verificamos si cabe en la línea actual antes de escribirla
		if not _cabe_palabra(palabra):
			text.text += "\n"

		for letra in palabra:
			if skip:
				text.text = linea
				typing = false
				return
			text.text += letra
			cont += 1
			if cont==2:
				sound.play()
				cont = 0
			await get_tree().create_timer(0.05).timeout
		text.text += " "  # espacio entre palabras
	typing = false

func _input(event):
	if event.is_action_pressed("ui_accept") or event.is_action_pressed("click_izquierdo"):
		if typing:
			# Si se está escribiendo → terminar de golpe
			skip = true
		else:
			# Si ya terminó → pasar al siguiente diálogo
			current_index += 1
			_show_dialogo()

func _cabe_palabra(palabra: String) -> bool:
	var font = text.get_theme_font("font")
	var font_size = text.get_theme_font_size("font_size")
	
	# Ancho actual del texto + ancho de la palabra
	var ancho_actual = font.get_string_size(text.text, HORIZONTAL_ALIGNMENT_LEFT, -1, font_size).x
	var ancho_palabra = font.get_string_size(palabra, HORIZONTAL_ALIGNMENT_LEFT, -1, font_size).x
	
	# ¿Cabe dentro del ancho del Label?
	return (ancho_actual + ancho_palabra) < text.size.x
