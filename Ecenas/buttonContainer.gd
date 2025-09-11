extends Control
@onready var guitarAR = $"guitar arriba"
@onready var guitarAB = $"guitar abajo"
@onready var animation = $"../AnimationPlayer"
@onready var sonido = $"../Guitarra"

func _ready() -> void:
	guitarAB.visible = false
	guitarAR.visible = false

func _on_button_mouse_entered() -> void:
	guitarAR.visible = true
	guitarAB.visible = true
	animation.play("guitarMove")
	sonido.play()


func _on_button_mouse_exited() -> void:
	guitarAR.visible = false
	guitarAB.visible = false
