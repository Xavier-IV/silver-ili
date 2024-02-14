extends Label


func _ready():
	GlobalSignal.connect("sig_salary_received", _on_sig_salary_received)


func _on_sig_salary_received():
	print("Updating, cashflow balance: %s" % GlobalCashflow.balance)
	text = "Balance: RM %s" % GlobalCashflow.balance
