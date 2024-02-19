extends Node


class Notification:
	var text: String
	var duration: float
	var createdAt: float = Time.get_unix_time_from_system()


signal sig_show_global_event(event: String)
signal sig_hide_global_event

signal sig_apply_job(job)
signal sig_salary_received

signal sig_notify(notification: Notification)
signal sig_notify_stat(notification: Notification)

signal sig_day_updated(day: int)
signal sig_month_updated(month: int)
signal sig_year_updated(year: int)
