extends Label


func _ready():
	GlobalDateTime.connect("sig_year_advanced", _on_year_advanced)
	_on_year_advanced()


func _on_year_advanced():
	text = "Year %s" % GlobalDateTime.current["year"]
