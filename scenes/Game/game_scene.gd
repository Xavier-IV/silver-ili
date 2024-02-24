extends Node3D

var notification_id = 0


func _ready():
	# GlobalDateTime.set_paused(false)
	GlobalSignal.connect("sig_apply_job", _on_apply_job)
	GlobalDateTime.connect("sig_salary_day", _on_salary_day)
	GlobalDateTime.connect("sig_day_advanced", _on_day_advanced)
	GlobalStat.begin_stat()
	$AudioStreamPlayer.play()
	if !GlobalEvent.completed_event("onboarding"):
		GlobalDateTime.set_paused(true)
		var title = "SoftwareDev RPG"
		var description = "Welcome! You will be exploring the life from the perspective of a software developer."
		GlobalModal.init_modal(self, title, description, ["Next [1/3]"], [_on_click_1])


func _on_click_1():
	var title = "What's Next?"
	var description = "Try to look for a job. Keep an eye out for the stats.\n"
	description += "[color=#2083cb](Mental+)[/color]\n"
	description += "[color=#d122bf](Creativity+)[/color]\n"
	description += "[color=#9ad056](Social+)[/color]\n"
	description += "\nDon't worry, you can take a look at the guide in the setting later."
	GlobalModal.init_modal(self, title, description, ["Next [2/3]"], [_on_click_2])


func _on_click_2():
	var title = "What's Next?"
	var description = "Some event will effect your stats.\n"
	description += "You will also have to pay some expenses from time to time, just like normal life.\n"
	description += "\nDecide your own goal; be rich, master all skills, get promoted, or just have fun!"

	GlobalEvent.complete_event("onboarding")
	GlobalSave.save()
	GlobalModal.init_modal(
		self, title, description, ["Let's Go!"], [func(): GlobalDateTime.set_paused(false)]
	)
	print(GlobalEvent.events)


func _on_timer_timeout():
	if GlobalDateTime.is_paused():
		return
	Profile.continuous_learning()
	GlobalDateTime.calendar_update()
	GlobalSave.save()


func _on_day_advanced():
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
	var _notification = GlobalSignal.Notification.new()
	_notification.text = "Congratulations! New job applied with '%s'" % job.name
	_notification.text += "\nSalary: RM %s" % job.salary
	_notification.duration = 1.0

	GlobalSignal.emit_signal("sig_notify", _notification)
