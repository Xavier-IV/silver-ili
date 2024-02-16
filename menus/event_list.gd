extends Label

var events = {}


func _ready():
	print("Event is ready...")
	GlobalSignal.connect("sig_notify", _on_sig_notify)


func _on_sig_notify(noti: GlobalSignal.Notification):
	events[noti.id] = noti

	var event_arr = events.values()
	event_arr.sort_custom(func(a, b): return a.createdAt - b.createdAt)
	text = "\n".join(event_arr.map(func(e): return e.text))
