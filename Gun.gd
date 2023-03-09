extends CharacterBody2D

signal shot

func _input(event):
	rotation -= -get_angle_to(get_global_mouse_position())

	if event is InputEventMouseButton:
		shot.emit()


func _on_character_turned(turned):
	$Sprite.flip_v = (turned)
