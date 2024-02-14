extends Button


func _ready():
	GlobalSignal.connect("sig_apply_job", _on_apply_job)


func _on_apply_job(job):
	visible = false
