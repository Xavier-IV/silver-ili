extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalSignal.connect("sig_apply_job", _on_apply_job)


func _on_apply_job(job):
	text = "Started Since: %s" % GlobalVar.employment_detail["job_start_date"]
