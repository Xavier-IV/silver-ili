extends Node

signal sig_hour_advanced
signal sig_day_advanced
signal sig_month_advanced
signal sig_year_advanced

signal sig_salary_day

var current = {
	"year": 1,
	"month": 1,
	"day": 27,
	"hour": 0,
}
var gameTimeCycles = {
	"monthMax": 12,
	"dayMax": 30,
	"hourMax": 24,
	"salaryDay": 28,
}


func get_day():
	return current["day"]


func hour_percentage():
	return float(current["hour"]) / float(gameTimeCycles["hourMax"]) * 100.0


func calendar_update():
	current["hour"] += 1
	emit_signal("sig_hour_advanced")

	if current["hour"] < gameTimeCycles["hourMax"]:
		return

	current["day"] += 1
	current["hour"] = 0

	handle_salary_day()
	emit_signal("sig_day_advanced")

	if current["day"] < gameTimeCycles["dayMax"]:
		return

	current["day"] = 1
	current["month"] += 1
	emit_signal("sig_day_advanced")
	emit_signal("sig_month_advanced")

	if current["month"] < gameTimeCycles["monthMax"]:
		return

	current["month"] = 1
	current["year"] += 1
	emit_signal("sig_day_advanced")
	emit_signal("sig_month_advanced")
	emit_signal("sig_year_advanced")


func handle_salary_day():
	print("handling salary day")
	if GlobalDateTime.current["day"] == GlobalDateTime.gameTimeCycles["salaryDay"]:
		emit_signal("sig_salary_day")
