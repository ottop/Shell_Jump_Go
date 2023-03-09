extends AnimatedSprite2D

@export var offset_quantity = 20

func _on_character_turned(turned):
	if turned == true:
		offset = Vector2(0, offset_quantity)
		
	else:
		offset = Vector2.ZERO

func _on_character_validshot():
	play("shoot")
