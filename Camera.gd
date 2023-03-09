extends Camera2D

signal bottom

func _process(delta):
	var screenBottom = get_screen_center_position().y + get_viewport_rect().size.y / 2
	limit_bottom = screenBottom
	bottom.emit(screenBottom)
