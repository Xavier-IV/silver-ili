extends Label


func _ready():
	GlobalSignal.connect("sig_salary_received", _on_sig_salary_received)
	GlobalCashflow.connect("sig_balance_deducted", _on_balance_deducted)
	update()


func _on_balance_deducted():
	update()


func _on_sig_salary_received():
	update()


func update():
	text = "Balance: RM %s" % str(GlobalCashflow.balance)
