extends CharacterBody2D

signal turned
signal validshot
signal dead

@export var floor_slideness = 0.7
@export var air_slideness = 1
@export var jump_boost = 1.8

@export var speed = 700.0
@export var max_jumps = 2
@export var jumps = max_jumps
@export var stay = true

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	var direction = sign(get_global_mouse_position().x - $Sprite.global_position.x)
	$Sprite.flip_h = direction < 0
	turned.emit(direction < 0)
	
	if is_on_floor() and stay == false:
		jumps = max_jumps
		$LandSound.play()
		stay = true
		
	velocity.y += gravity * delta
	
	if is_on_floor():
		velocity.x = velocity.x * floor_slideness
		
	else: 
		velocity.x = velocity.x * air_slideness
		
	
	move_and_slide()

func _on_gun_shot():
	
	if (jumps > 0):
		
		var sped = Vector2.ZERO
		
		sped.x = $Sprite.global_transform.origin.x - $Sprite.get_global_mouse_position().x
		sped.y = $Sprite.global_transform.origin.y - $Sprite.get_global_mouse_position().y
		
		if jumps < max_jumps:
			velocity = sped.normalized() * speed * jump_boost
			
		else:
			velocity = sped.normalized() * speed
		validshot.emit()
		await get_tree().create_timer(0.015).timeout
		jumps -= 1
		stay = false
	

func start(pos):
	position = pos
	show()

func _on_camera_2d_bottom(bottom):
	if global_transform.origin.y > bottom:
		dead.emit()
