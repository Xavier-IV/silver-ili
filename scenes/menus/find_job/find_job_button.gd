extends Button


func _ready():
	GlobalSignal.connect("sig_apply_job", _on_apply_job)
	if GlobalVar.employed():
		visible = false


func _on_apply_job(_job):
	visible = false


func _on_pressed():
	%FindJobPanel.visible = true
	# print("exec job")
	# var margin = MarginContainer.new()
	# margin.add_theme_constant_override("margin_left", 20)
	# margin.add_theme_constant_override("margin_top", 20)
	# margin.add_theme_constant_override("margin_right", 20)
	# margin.add_theme_constant_override("margin_bottom", 20)

	# var job_panel = preload("res://scenes/menus/panels/section_panel.tscn").instantiate()
	# job_panel.section_name = "Find Job"
	# margin.add_child(job_panel)
	# %SideControl.add_child(margin)
	# # %SideControl.move_child(margin, 0)
