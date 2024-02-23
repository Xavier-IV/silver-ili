extends MarginContainer

var _job = {}


# Called when the node enters the scene tree for the first time.
func set_detail(job):
	_job = job
	%Title.text = job["name"]
	%Description.text = job["description"]
	%Salary.text = "RM %s" % job["salary"]


func _on_button_pressed():
	GlobalVar.current_job = _job

	GlobalVar.employment_detail["job_id"] = _job.id
	GlobalVar.employment_detail["employer_name"] = _job.name
	GlobalVar.employment_detail["salary"] = _job.salary
	GlobalVar.employment_detail["start_date"] = Time.get_datetime_string_from_system()

	GlobalSignal.emit_signal("sig_apply_job", _job)
