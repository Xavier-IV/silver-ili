extends Node

signal sig_balance_deducted
signal sig_overdue_updated

var salary = 0
var balance = 0

var expenses = {"0": {"name": "Rent", "amount": 500, "chargeDay": 29, "chargeHour": 12}}
var overdue = {}


func _ready():
	GlobalSignal.connect("sig_apply_job", _on_apply_job)
	GlobalDateTime.connect("sig_day_advanced", _on_day_advanced)
	GlobalDateTime.connect("sig_hour_advanced", _on_hour_advanced)


func _on_hour_advanced():
	var current_balance = balance
	for expense in expenses.values():
		if (
			(
				GlobalDateTime.get_day()
				!= min(expense.chargeDay, GlobalDateTime.gameTimeCycles["dayMax"])
			)
			|| float(GlobalDateTime.get_hour()) != float(expense.chargeHour)
		):
			continue

		var _notification = GlobalSignal.Notification.new()
		_notification.duration = 1.0

		if float(expense.amount) > float(current_balance):
			overdue[expense.name] = {
				"amount": overdue.get(expense.name, {"amount": 0})["amount"] + expense.amount,
				"overdue_times":
				overdue.get(expense.name, {"overdue_times": 0})["overdue_times"] + 1,
				"mental_health_deduction": 40,
			}
			var overdue_times = overdue[expense.name]["overdue_times"]
			_notification.text = (
				"You haven't paid for [color=#FF9494]%s[/color] (%s) times"
				% [
					expense.name,
					overdue_times,
				]
			)

			emit_signal("sig_overdue_updated")
			GlobalSignal.emit_signal("sig_notify", _notification)
			GlobalStat.deduct_stat_now("mental_health", 40)
		else:
			balance -= expense.amount

			_notification.text = "You paid RM %s for %s" % [expense.amount, expense.name]

			GlobalSignal.emit_signal("sig_notify", _notification)
			GlobalStat.deduct_stat_now("mental_health", 15)

	if current_balance != balance:
		emit_signal("sig_balance_deducted")


func _on_day_advanced():
	pass


func _on_apply_job(job):
	salary = job.salary


func get_overdue_amount():
	var total = 0
	for expense in overdue.values():
		total += expense["amount"]
	return total
