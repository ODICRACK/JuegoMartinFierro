extends Sprite2D
@export var recurso:Personas
@onready var animador = $AnimationPlayer
signal dialogo(nombre:String, cantDialogos:int,Sprite:Texture2D,SpriteGrande:Texture2D,Dialogos)

func _ready() -> void:
	animador.play(recurso.animado)
	texture = recurso.sprite
	hframes = recurso.hframes
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if  body.is_in_group("player"):
		emit_signal("dialogo",recurso.nombre,recurso.cantDialogos,recurso.sprite,recurso.spriteGrande,recurso.dialogos)
		print ("esta entrando ")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	emit_signal("dialogo",recurso.nombre,recurso.cantDialogos,recurso.sprite,recurso.spriteGrande,recurso.dialogos)
