extends Node
class_name movement
@export var velocidad: float = 32.0
@export var max_velocidad:float = 32.0
var character: CharacterBody2D



func setup(character2D:CharacterBody2D):
	character = character2D
	
func move (Input_vector: Vector2):
	character.velocity = Input_vector.normalized()* velocidad
	character.move_and_slide()
	
func stop_movement():
	character.velocity = Vector2.ZERO
