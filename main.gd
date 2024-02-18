extends Node3D

var notification_id = 0


func _ready():
	GlobalSignal.connect("sig_apply_job", _on_apply_job)
	GlobalDateTime.connect("sig_salary_day", _on_salary_day)
	GlobalDateTime.connect("sig_day_advanced", _on_day_advanced)
	GlobalStat.begin_stat()


func _on_timer_timeout():
	GlobalDateTime.calendar_update()


func _on_day_advanced():
	print("Day advanced.")
	GlobalStat.conclude_stat()
	GlobalStat.begin_stat()


func _on_salary_day():
	if GlobalCashflow.salary == 0:
		return

	GlobalCashflow.balance += GlobalCashflow.salary

	var _notification = GlobalSignal.Notification.new()
	_notification.text = "Payday! Time to splurge~"
	_notification.duration = 1.0

	GlobalSignal.emit_signal("sig_notify", _notification)
	GlobalSignal.emit_signal("sig_salary_received")
	GlobalStat.improve_stat_now("mental_health", 25)

	quick_settle_overdue()


func quick_settle_overdue():
	var _notification = GlobalSignal.Notification.new()
	_notification.duration = 1.0
	for expense in GlobalCashflow.expenses.values():
		if !GlobalCashflow.overdue.has(expense.name):
			continue

		# TODO: Prompt user how much to pay for overdue in UI
		if float(GlobalCashflow.overdue[expense.name].amount) < float(GlobalCashflow.balance):
			GlobalCashflow.balance -= float(GlobalCashflow.overdue[expense.name].amount)

			_notification.text = (
				"[color=orange]Salary! You paid RM %s for all %s overdues! That's a relief..[/color]"
				% [expense.amount, expense.name]
			)
			_notification.duration = 1.0

			GlobalStat.improve_stat_now(
				"mental_health", GlobalCashflow.overdue[expense.name]["mental_health_deduction"]
			)
			GlobalSignal.emit_signal("sig_notify", _notification)
			GlobalCashflow.overdue.erase(expense.name)
			GlobalCashflow.emit_signal("sig_overdue_updated")
			GlobalCashflow.emit_signal("sig_balance_deducted")
			continue


func _on_apply_job(job):
	print("New job applied.")
	var _notification = GlobalSignal.Notification.new()
	_notification.text = "Congratulations! New job applied with '%s'" % job.name
	_notification.text += "\nSalary: RM %s" % job.salary
	_notification.duration = 1.0

	GlobalSignal.emit_signal("sig_notify", _notification)
