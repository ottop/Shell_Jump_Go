extends Node

signal score_up

@export var pf_scene: PackedScene
@export var pf_scene2: PackedScene
@export var pf_scene3: PackedScene
@export var pf_scene4: PackedScene
@export var char_scene: PackedScene
@export var wall_scene: PackedScene
@export var bg_scene: PackedScene

@export var scaling = 0.6
@export var pos_y_min = 260
@export var pos_y_max = 320
@export var pos_x_min = 30
@export var pos_x_max = 430
@export var start_y_minus = 300
@export var bg_offset = 1800
@export var bg_x_offset = -100
@export var start_timer = 0.015

@export var start_platforms = 10

@export var mobile_scale_char = 1.35
@export var mobile_scale_pf = 1.25
@export var mobile_scale_wall = 1.18

var prev_pos
var platforms = []
var prev_height = 0
var started = false

var char
var wall
var bg

func _ready():
	#For Android:
	pos_y_min = pos_y_min * 1.17
	pos_y_max = pos_y_max * 1.02
	
	new_game()
	
func _process(delta):
	
	if (char != null):
		
		if (char.position.y < prev_height):
			prev_height = char.position.y
			wall.position.y = prev_height
			bg.position.y = prev_height - bg_offset
			
		if started == true and char.get_last_slide_collision() != null:
			
			for i in range(platforms.size()):			
				
				if platforms[-i-1] == char.get_last_slide_collision().get_collider():
					
					for j in range(platforms.size()-i):
						make_platform(false)
						platforms.remove_at(0)
						score_up.emit()
						
					break
		else: if char.get_last_slide_collision() != null:
			if $StartPlatform == char.get_last_slide_collision().get_collider():
				$Logo.queue_free()
				for x in range(start_platforms):
					make_platform(false)
				$HUD/Pause.show()
				$HUD/Scoreblock.show()
				$HUD/ScoreLabel.show()
				started = true
				

func make_platform(first):
	var scene = randi_range(0,3)
	var pf
	
	if scene == 0:
		pf = pf_scene.instantiate()
		
	else: if scene == 1:
		pf = pf_scene2.instantiate()
		
	else: if scene == 2:
		pf = pf_scene3.instantiate()
	
	else: if scene == 3:
		pf = pf_scene4.instantiate()
	
	if first == false:
		pf.position.y=prev_pos.y
		pf.position.y -= randf_range(pos_y_min, pos_y_max)
		
	else:
		pf.position.y=char.global_transform.origin.x
		pf.position.y -= randf_range(pos_y_min-start_y_minus, pos_y_max-start_y_minus)
	
	pf.position.x += randf_range(pos_x_min,pos_x_max)
	
	# For Android build
	pf.scale = Vector2(mobile_scale_pf,mobile_scale_pf)
	
	add_child(pf)
	
	prev_pos = pf.position
	
	platforms.append(pf)

func new_game():
	await get_tree().create_timer(start_timer).timeout
	bg = bg_scene.instantiate()
	bg.position.x += bg_x_offset
	add_child(bg)
	wall = wall_scene.instantiate()
	
	#For Android
	wall.scale = Vector2(mobile_scale_wall,mobile_scale_wall)
	
	add_child(wall)
	char = char_scene.instantiate()
	
	# For Android
	char.scale = Vector2(mobile_scale_char,mobile_scale_char)
	
	add_child(char)
	char.dead.connect(_on_character_dead)
	$Ground.show()
	$HUD/pausebg.hide()
	
	char.start($Start.position)
	$Music.play()
	if started == true:
		make_platform(true)
		$HUD/Pause.show()
		for x in range(start_platforms):
			make_platform(false)
	else:
		$StartPlatform.show()
		prev_pos = $StartPlatform.position
		platforms.append($StartPlatform)
	
	

func _on_character_dead():
	char.queue_free()
	get_tree().call_group("pfs", "queue_free")
	$HUD/pausebg.show()
	$HUD/Gameover.show()
	$HUD/Restart.show()
	$HUD/Quit.show()
	bg.queue_free()
	wall.queue_free()
	$Ground.hide()
	$HUD/Pause.hide()
	$Music.stop()
	prev_height = 0
	platforms = []
	prev_pos = null
	$GameOverSound.play()
	
func _on_hud_pause():
	get_tree().paused = true
	$HUD/Pause.hide()
	$HUD/pausebg.show()
	$HUD/Continue.show()
	$HUD/Quit.show()
	$HUD/PauseText.show()


func _on_hud_resume():
	$HUD/PauseText.hide()
	$HUD/Continue.hide()
	$HUD/Quit.hide()
	$HUD/pausebg.hide()
	$HUD/Pause.show()
	await get_tree().create_timer(start_timer).timeout
	get_tree().paused = false
