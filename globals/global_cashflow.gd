extends Node

signal sig_balance_deducted

var salary = 0
var balance = 0

var expenses = {"0": {"name": "Rent", "amount": 500, "chargeDay": 29}}


func _ready():
	GlobalSignal.connect("sig_apply_job", _on_apply_job)
	GlobalDateTime.connect("sig_day_advanced", _on_day_advanced)


func _on_day_advanced():
	var current_balance = balance
	for expense in expenses.values():
		if GlobalDateTime.get_day() != expense.chargeDay:
			continue

		balance -= expense.amount
		var _notification = GlobalSignal.Notification.new()
		_notification.text = "You paid RM %s for %s" % [expense.amount, expense.name]
		_notification.duration = 1.0
		_notification.id = randi_range(0, 10)

		GlobalSignal.emit_signal("sig_notify", _notification)

	if current_balance != balance:
		emit_signal("sig_balance_deducted")


func _on_apply_job(job):
	salary = job.salary
