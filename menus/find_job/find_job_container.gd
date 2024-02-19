extends Control


func _ready():
	GlobalSignal.connect("sig_apply_job", _on_apply_job)


func _on_apply_job(_job):
	visible = false


func _on_close_button_pressed():
	visible = false
