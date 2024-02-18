extends Label


func _ready():
	GlobalDateTime.connect("sig_hour_advanced", _on_sig_hour_advanced)
	set_time()


func _on_sig_hour_advanced():
	set_time()


func set_time():
	var str_hour = str(GlobalDateTime.current["hour"])
	if GlobalDateTime.current["hour"] < 10:
		str_hour = "0" + str(GlobalDateTime.current["hour"])

	text = "%s:00" % str_hour
