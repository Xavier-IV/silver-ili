extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalSignal.connect("sig_apply_job", _on_apply_job)
	update()


func _on_apply_job(job):
	update()


func update():
	text = "Started Since: %s" % GlobalVar.employment_detail["start_date"]
