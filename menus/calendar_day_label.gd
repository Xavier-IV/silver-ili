extends Label


func _ready():
	GlobalDateTime.connect("sig_day_advanced", _on_day_advanced)
	_on_day_advanced()

func _on_day_advanced():
	text = "Day %s" % GlobalDateTime.current["day"]
