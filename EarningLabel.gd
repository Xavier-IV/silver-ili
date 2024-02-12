extends Label


func _update_income(value):
	print("Running in label")

	if value < 1000:
		text = "Earning: RM %.2f" % (value / 100)
	elif value >= 1000:
		text = "Earning: RM %s" % (value / 100)
