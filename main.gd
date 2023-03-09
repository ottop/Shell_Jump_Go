extends Node

@export var pf_scene: PackedScene
@export var scaling = 0.6
@export var pos_y_min = 150
@export var pos_y_max = 250
@export var pos_x_min = 44
@export var pos_x_max = 403

var prev_pos

func _ready():
	$Character.start($Start.position)
	var pf = pf_scene.instantiate()
	pf.scale = Vector2(scaling,scaling)
	pf.position.y=$Character.global_transform.origin.x
	pf.position.y -= randf_range(pos_y_min-200, pos_y_max-200)
	pf.position.x += randf_range(pos_x_min,pos_x_max)
	add_child(pf)
	prev_pos = pf.position

func _process(delta):
	var pf = pf_scene.instantiate()
	pf.scale = Vector2(scaling,scaling)
	pf.position.y=prev_pos.y
	pf.position.y -= randf_range(pos_y_min, pos_y_max)
	pf.position.x += randf_range(pos_x_min,pos_x_max)
	add_child(pf)
	prev_pos = pf.position
