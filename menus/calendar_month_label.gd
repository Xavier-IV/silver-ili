extends Label


func _ready():
	GlobalDateTime.connect("sig_month_advanced", _on_month_advanced)
	_on_month_advanced()

func _on_month_advanced():
	text = "Month %s" % GlobalDateTime.current["month"]
