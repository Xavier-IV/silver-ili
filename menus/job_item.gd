extends MarginContainer

var _job = {}


# Called when the node enters the scene tree for the first time.
func set_detail(job):
	_job = job
	$VBoxContainer/HBoxContainer/Title.text = job["name"]
	$VBoxContainer/Description.text = job["description"]
	$VBoxContainer/Salary.text = "RM %s" % job["salary"]


func _on_button_pressed():
	GlobalVar.current_job = _job
	GlobalSignal.emit_signal("sig_apply_job", _job)
