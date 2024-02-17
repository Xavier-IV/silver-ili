extends Node3D

var notification_id = 0


func _ready():
	GlobalSignal.connect("sig_apply_job", _on_apply_job)
	GlobalDateTime.connect("sig_salary_day", _on_salary_day)


func _on_timer_timeout():
	GlobalDateTime.calendar_update()


func _on_salary_day():
	if GlobalCashflow.salary == 0:
		return

	GlobalCashflow.balance += GlobalCashflow.salary

	var _notification = GlobalSignal.Notification.new()
	_notification.text = "Payday! Time to splurge~"
	_notification.duration = 1.0

	GlobalSignal.emit_signal("sig_notify", _notification)
	GlobalSignal.emit_signal("sig_salary_received")


func _on_apply_job(job):
	print("New job applied.")
	var _notification = GlobalSignal.Notification.new()
	_notification.text = "Congratulations! New job applied with '%s'" % job.name
	_notification.text += "\nSalary: RM %s" % job.salary
	_notification.duration = 1.0

	GlobalSignal.emit_signal("sig_notify", _notification)

	print(GlobalVar.employment_detail)
