extends Button


func _on_pressed():
	print("exec")
	%CareerPanel.visible = true
# 	var margin = MarginContainer.new()
# 	margin.z_index = 3
# 	margin.add_theme_constant_override("margin_left", 20)
# 	margin.add_theme_constant_override("margin_top", 20)
# 	margin.add_theme_constant_override("margin_right", 20)
# 	margin.add_theme_constant_override("margin_bottom", 20)

# 	var career_panel = preload("res://scenes/menus/panels/section_panel.tscn").instantiate()
# 	career_panel.section_name = "My Career"
# 	career_panel.connect("_on_close_button_pressed", _on_close_button_pressed)
# 	margin.add_child(career_panel)
# 	%SideControl.add_child(margin)
# 	# %SideControl.move_child(margin, 0)

# func _on_close_button_pressed():
# 	print("close")
# %SideControl.remove_child(%SideControl.get_child(0))
