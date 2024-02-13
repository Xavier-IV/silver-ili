extends Node

signal sig_hour_advanced
signal sig_day_advanced
signal sig_month_advanced
signal sig_year_advanced

signal sig_salary_day

var current = {
	"year": 1,
	"month": 1,
	"day": 1,
	"hour": 0,
}
var gameTimeCycles = {
	"monthMax": 4,
	"dayMax": 4,
	"hourMax": 4,
	"salaryDay": 2,
}


func hour_percentage():
	return float(current["hour"]) / float(gameTimeCycles["hourMax"]) * 100.0


func calendar_update():
	print(current)
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
	if (
		GlobalDateTime.current["day"] == GlobalDateTime.gameTimeCycles["salaryDay"]
		&& GlobalDateTime.current["hour"] == GlobalDateTime.gameTimeCycles["hourMax"]
	):
		emit_signal("sig_salary_day")
