extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalSignal.connect("sig_show_global_event", _on_show_global_event)
	GlobalSignal.connect("sig_hide_global_event", _on_hide_global_event)


func _on_show_global_event(event):
	text = event


func _on_hide_global_event():
	pass
