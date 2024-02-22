extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	GlobalSignal.connect("sig_salary_received", _on_sig_salary_received)
	GlobalCashflow.connect("sig_overdue_updated", _on_overdue_updated)
	_on_overdue_updated()


func _on_sig_salary_received():
	pass


func _on_overdue_updated():
	var overdue_amount = GlobalCashflow.get_overdue_amount()
	if overdue_amount > 0:
		text = "Overdue: " + str(overdue_amount)
		visible = true
	else:
		visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
