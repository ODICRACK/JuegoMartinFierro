extends AnimationPlayer
@onready var cancion = $"../Payada"
@onready var gente = $"../Persoanas/Gente"

signal playercorrecto

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		ConfigManager.moverse = false
		gente.stop()
		emit_signal("playercorrecto")
		await get_tree().create_timer(0.5).timeout
		cancion.play()
		play("payada")
		print (" en animacion")


func _on_animation_finished(anim_name: StringName) -> void:
	cancion.stop()
	
