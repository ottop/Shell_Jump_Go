extends Camera2D

func _process(delta):
	limit_bottom = get_screen_center_position().y + get_viewport_rect().size.y / 2
