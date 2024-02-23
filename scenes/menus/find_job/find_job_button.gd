extends Button


func _ready():
	GlobalSignal.connect("sig_apply_job", _on_apply_job)
	if GlobalVar.employed():
		visible = false


func _on_apply_job(_job):
	visible = false


func _on_pressed():
	%FindJobPanel.visible = true
