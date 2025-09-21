extends CharacterBody2D

@export var velocidad:int = 50
@onready var animador = $AnimationPlayer
@onready var camara = $Camera2D

signal OcultarMostrarSprites(correcto:int)
signal MostrarCorrecto
var permiso:bool = true

func _ready() -> void:
	camara.position = Vector2(0,0)


func _physics_process(_delta: float) -> void:
	
	var direccion = Input.get_vector("Izq","Dere","Arriba","Abajo")
	
	if ConfigManager.moverse == true:
		velocity = direccion * velocidad
		move_and_slide()
	
func _input(_event: InputEvent) -> void:
	var accion :=Comprobador()

	if permiso == true:
		if accion == "Izq":
			animador.play("Izq")
			emit_signal("OcultarMostrarSprites",(3))
		elif accion == "Dere":
			animador.play("Dere")
			emit_signal("OcultarMostrarSprites",(1))
		elif accion == "Arriba":
			animador.play("Up")
			emit_signal("OcultarMostrarSprites",(5))
		elif accion == "Abajo":
			animador.play("Dawn")
			emit_signal("OcultarMostrarSprites",(4))
		else:
			animador.play("Idle")
			emit_signal("OcultarMostrarSprites",(2))

func Comprobador()-> String:
	# 🔽 Cambiá este orden según la prioridad que quieras
	var prioridad = ["Izq", "Dere", "Arriba", "Abajo"]

	for accion in prioridad:
		if Input.is_action_pressed(accion):
			return accion
	
	return "" # Ninguna tecla


func _on_animation_player_playercorrecto() -> void:
	permiso = false
	animador.play("Idle")
	emit_signal("MostrarCorrecto")
	await get_tree().create_timer(0.5).timeout
	
	
