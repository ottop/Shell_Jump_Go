extends AnimatedSprite2D

@export var offset_quantity_y = 20
@export var offset_quantity_x = 0

func _on_character_turned(turned):
	if turned == true:
		offset = Vector2(offset_quantity_x, offset_quantity_y)
		
	else:
		offset = Vector2.ZERO

func _on_character_validshot():
	$ExplosionSound.play()
	play("shoot")
