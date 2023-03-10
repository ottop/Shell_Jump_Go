extends CharacterBody2D

signal shot
var screenBottom = 0

func _input(event):
	rotation -= -get_angle_to(get_global_mouse_position())
	
	if event is InputEventMouseButton and (get_global_mouse_position().y > screenBottom-830 or get_global_mouse_position().x > -20):
		shot.emit()


func _on_character_turned(turned):
	$Sprite.flip_v = (turned)


func _on_camera_2d_bottom(bottom):
	screenBottom = bottom
