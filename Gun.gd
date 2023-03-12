extends CharacterBody2D

signal shot
var screenBottom = 0

@export var mouse_deadzone_y = 820
@export var mouse_deadzone_x = -20

@export var mobile_deadzone_y = 1200
@export var mobile_deadzone_x = 52

func _input(event):
	rotation -= -get_angle_to(get_global_mouse_position())
	
	#Desktop
	#if Input.is_action_just_pressed("click") and (get_global_mouse_position().y > screenBottom-mouse_deadzone_y or get_global_mouse_position().x > mouse_deadzone_x):
	
	#Android
	if event is InputEventScreenTouch and event.is_pressed() and (get_global_mouse_position().y > screenBottom-mobile_deadzone_y or get_global_mouse_position().x > mobile_deadzone_x):
		
		shot.emit()


func _on_character_turned(turned):
	$Sprite.flip_v = (turned)


func _on_camera_2d_bottom(bottom):
	screenBottom = bottom
