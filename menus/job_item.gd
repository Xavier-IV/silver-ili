extends MarginContainer

var job_title: String = ""


# Called when the node enters the scene tree for the first time.
func set_detail(title, description):
	job_title = title
	$VBoxContainer/HBoxContainer/Title.text = title
	$VBoxContainer/Description.text = description


func _on_button_pressed():
	print("User applying job!")
	GlobalSignal.emit_signal("sig_apply_job", job_title)
