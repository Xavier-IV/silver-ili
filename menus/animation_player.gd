extends AnimationPlayer


func _ready():
	GlobalSignal.connect("sig_apply_job", _on_apply_job)
	GlobalSignal.connect("sig_salary_received", _on_sig_salary_received)
	GlobalCashflow.connect("sig_balance_deducted", _on_balance_deducted)


func _on_apply_job(_job):
	play("animate_salary")


func _on_sig_salary_received():
	play("animate_balance")


func _on_balance_deducted():
	play("animate_balance_deducted")
