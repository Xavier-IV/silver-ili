extends Node


class Notification:
	var id: int
	var text: String
	var duration: float


signal sig_apply_job(job)
signal sig_salary_received

signal sig_notify(notification: Notification)

signal sig_day_updated(day: int)
signal sig_month_updated(month: int)
signal sig_year_updated(year: int)
