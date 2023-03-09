extends Node

@export var pf_scene: PackedScene
@export var scaling = 0.6
@export var pos_y_min = 150
@export var pos_y_max = 350
@export var pos_x_min = 44
@export var pos_x_max = 403
@export var start_y_minus = 300

var prev_pos
var platforms = []

func _ready():
	$Character.start($Start.position)
	
	make_platform(true)
	
	for x in range(10):
		make_platform(false)
	
func _process(delta):

	if $Character.get_last_slide_collision() != null:
		
		for i in range(platforms.size()):			
			
			if platforms[-i-1] == $Character.get_last_slide_collision().get_collider():
				
				for j in range(platforms.size()-i-1):
					make_platform(false)
					platforms.remove_at(0)
					
				break

func make_platform(first):
	var pf = pf_scene.instantiate()
	pf.scale = Vector2(scaling,scaling)
	
	if first == false:
		pf.position.y=prev_pos.y
		pf.position.y -= randf_range(pos_y_min, pos_y_max)
		
	else:
		pf.position.y=$Character.global_transform.origin.x
		pf.position.y -= randf_range(pos_y_min-start_y_minus, pos_y_max-start_y_minus)
	
	pf.position.x += randf_range(pos_x_min,pos_x_max)
	
	add_child(pf)
	
	prev_pos = pf.position
	
	platforms.append(pf)
