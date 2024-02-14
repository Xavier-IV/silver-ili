extends Label

var events = {}


func _ready():
	print("Event is ready...")
	GlobalSignal.connect("sig_notify", _on_sig_notify)


func _on_sig_notify(notification: GlobalSignal.Notification):
	events[notification.id] = notification

	var event_arr = events.values()
	event_arr.sort_custom(func(a, b): return a.id < b.id)
	text = "\n".join(event_arr.map(func(e): return e.text))
