extends Node3D

@export var seconds: int = 0

var currencyUnit: int = 100

# We will use this when the game started
var gameData = {
	"time":
	{
		"year": 0,
		"month": 12,
		"day": 1,
		"hour": 0,
	},
	"salary": 2500,
	"balance": 0,
}

var gameTimeCycles = {
	"monthMax": 12,
	"dayMax": 3,
	"hourMax": 24,
	"salaryDay": 2,
}

var salaryDay: int = 28

var monthlyExpenses = [
	{"name": "Rent", "amount": 300},
]

# GAME LOGICS
# ------------
# User should earn money on day 28th


func _ready():
	$UserInterface/EarningLabel._update_income(gameData["balance"])
	$UserInterface/ProgressBar.value = gameData["time"]["hour"] / 24.0 * 100

	$UserInterface/ProgressBar/DayLabel._update_day(gameData["time"]["day"])
	$UserInterface/CalendarMonthLabel._update_month(gameData["time"]["month"])
	$UserInterface/CalendarYearLabel._update_year(gameData["time"]["year"])


func _on_timer_timeout():
	seconds += 1
	gameData["time"]["hour"] += 1

	$UserInterface/ProgressBar/DayLabel._update_day(gameData["time"]["day"])
	$UserInterface/ProgressBar.value = gameData["time"]["hour"] / 24.0 * 100

	if gameData["time"]["day"] == gameTimeCycles["salaryDay"] && gameData["time"]["hour"] == 24:
		gameData["balance"] += gameData["salary"] * currencyUnit

		for monthlyExpense in monthlyExpenses:
			gameData["balance"] -= monthlyExpense["amount"] * currencyUnit
			$UserInterface/EventLabel/EventList._prepend_event(
				"    Spent on " + monthlyExpense["name"] + "!"
			)

		if gameData["balance"] < 1000:
			$UserInterface/EarningLabel._update_income(gameData["balance"])
			$UserInterface/EventLabel/EventList._prepend_event("You've received your salary!")
		elif gameData["balance"] >= 1000 && gameData["balance"] % 500 == 0:
			$UserInterface/EarningLabel._update_income(gameData["balance"])
			$UserInterface/EventLabel/EventList._prepend_event("You've received your salary!")

	if gameData["time"]["hour"] == gameTimeCycles["hourMax"]:
		print("in calendar check")
		$UserInterface/EventLabel/EventList._extend_event()
		$UserInterface/EventLabel/EventList._clear_since(1)

		gameData["time"]["day"] += 1
		gameData["time"]["hour"] = 0

		if gameData["time"]["day"] > gameTimeCycles["dayMax"]:
			print("Reset Month, Inc Day")

			if gameData["time"]["month"] >= gameTimeCycles["monthMax"]:
				print("Reset Month, Inc Year")
				gameData["time"]["month"] = 0
				gameData["time"]["year"] += 1
				$UserInterface/CalendarYearLabel._update_year(gameData["time"]["year"])

			gameData["time"]["day"] = 1
			gameData["time"]["month"] += 1
			$UserInterface/CalendarMonthLabel._update_month(gameData["time"]["month"])
