extends AnimationPlayer
@onready var cancion = $"../Payada"
@onready var gente = $"../Persoanas/Gente"

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		ConfigManager.moverse = false
		gente.stop()
		await get_tree().create_timer(0.5).timeout
		cancion.play()
		play("payada")
		print (" en animacion")
