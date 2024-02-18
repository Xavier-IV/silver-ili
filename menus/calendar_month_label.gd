extends Label


func _ready():
	GlobalDateTime.connect("sig_day_advanced", _on_advanced)
	GlobalDateTime.connect("sig_month_advanced", _on_advanced)


func _on_advanced():
	text = "%s/%s" % [GlobalDateTime.get_day_padded(), GlobalDateTime.get_month_padded()]
