extends Node2D
@onready var sprites =[null,$FierroDere,$FierroIdle,$FierroIzq,$FierroRun,$FierroUp]

func _on_personaje_ocultar_mostrar_sprites(correcto: int) -> void:
	if ConfigManager.moverse == true:
		for i in range(1, sprites.size()):
			sprites[i].visible = false
	
		sprites[correcto].visible= true
