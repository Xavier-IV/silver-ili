extends Node


func _ready():
	GlobalDateTime.connect("sig_hour_advanced", _on_hour_advanced)


func currently_working():
	if not GlobalVar.employed():
		return false

	var workingDays = GlobalVar.employment_detail["working_days"]
	var currentDay = GlobalDateTime.get_day()

	var workingHours = GlobalVar.employment_detail["working_hours"]
	var currentHour = GlobalDateTime.get_hour()

	var isWorking = currentHour >= workingHours[0] and currentHour <= workingHours[1]

	return true if workingDays.has(currentDay) && isWorking else false


func _on_hour_advanced():
	if currently_working():
		if GlobalDateTime.get_hour() == GlobalVar.employment_detail["working_hours"][0]:
			var _notification = GlobalSignal.Notification.new()

			_notification.text = "[color=#4e505d]You start working.[/color]"
			_notification.duration = 1.0

			GlobalSignal.emit_signal("sig_notify", _notification)

		# You socialize a little bit while working
		if randf() < 0.8:
			var _notification = GlobalSignal.Notification.new()

			_notification.text = "[color=#9ad056](Social+)[/color] [color=#4e505d]Socializing with co-worker.[/color]"
			_notification.duration = 1.0

			GlobalSignal.emit_signal("sig_notify_stat", _notification)
			GlobalStat.improve_stat_now("social_health", 0.1)
			GlobalStat.improve_stat_now("work_reputation", 0.1)

		if randf() < 0.5:
			var _notification = GlobalSignal.Notification.new()

			_notification.text = "[color=#2083cb](Mental-)[/color] [color=#4e505d]Working on task.[/color]"
			_notification.duration = 1.0

			GlobalSignal.emit_signal("sig_notify_stat", _notification)
			GlobalStat.deduct_stat_now("mental_health", 0.8)
			GlobalStat.improve_stat_now("work_reputation", 0.1)

		if GlobalDateTime.get_hour() == GlobalVar.employment_detail["working_hours"][1]:
			var _notification = GlobalSignal.Notification.new()

			_notification.text = "[color=#2083cb](Mental+)[/color] [color=#4e505d]Finished working![/color]"
			_notification.duration = 1.0

			GlobalStat.improve_stat_now("mental_health", 1)
			GlobalSignal.emit_signal("sig_notify_stat", _notification)
