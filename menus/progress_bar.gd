extends ProgressBar


func _ready():
	GlobalDateTime.connect("sig_hour_advanced", _on_sig_hour_advanced)


func _on_sig_hour_advanced():
	value = GlobalDateTime.hour_percentage()
