extends Label


func _ready():
	GlobalDateTime.connect("sig_day_advanced", _on_day_advanced)
	_on_day_advanced()


func _on_day_advanced():
	text = GlobalDateTime.get_day_in_week()
	if text == "Sat" or text == "Sun":
		add_theme_color_override("font_color", Color.ORANGE_RED)
	else:
		add_theme_color_override("font_color", Color.WHITE)
