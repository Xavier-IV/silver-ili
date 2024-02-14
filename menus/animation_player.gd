extends AnimationPlayer


func _ready():
	GlobalSignal.connect("sig_apply_job", _on_apply_job)
	GlobalSignal.connect("sig_salary_received", _on_sig_salary_received)


func _on_apply_job(job):
	play("animate_salary")


func _on_sig_salary_received():
	play("animate_balance")
