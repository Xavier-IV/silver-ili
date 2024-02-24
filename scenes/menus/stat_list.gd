extends RichTextLabel

var stat_events = {}


func _ready():
	GlobalSignal.connect("sig_notify_stat", _on_sig_notify)


func _on_sig_notify(noti: GlobalSignal.Notification):
	stat_events[noti.createdAt] = noti

	var event_arr = stat_events.values()
	event_arr.sort_custom(func(a, b): return a.createdAt - b.createdAt > 0)
	text = "\n".join(event_arr.slice(0, 1).map(func(e): return e.text))
