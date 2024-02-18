extends Label


func _ready():
	GlobalSignal.connect("sig_salary_received", _on_sig_salary_received)
	GlobalCashflow.connect("sig_balance_deducted", _on_balance_deducted)


func _on_balance_deducted():
	text = "Balance: RM %s" % GlobalCashflow.balance


func _on_sig_salary_received():
	text = "Balance: RM %s" % GlobalCashflow.balance
