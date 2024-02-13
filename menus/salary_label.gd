extends Label

func _update_value(value):
	print("Running in label")

	text = "Salary: RM %s" % (value / 100)
