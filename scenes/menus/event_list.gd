extends RichTextLabel

var events = {}


func _ready():
	GlobalSignal.connect("sig_notify", _on_sig_notify)


func _on_sig_notify(noti: GlobalSignal.Notification):
	events[noti.createdAt] = noti

	var event_arr = events.values()
	event_arr.sort_custom(func(a, b): return a.createdAt - b.createdAt > 0)
	text = "\n".join(event_arr.slice(0, 3).map(func(e): return e.text))
