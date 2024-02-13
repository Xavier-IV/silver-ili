extends Label

var events = []

func _extend_event():
	events.map(func(e):
		e['duration_since'] += 1
		return e
	)

func _clear_since(duration):
	events = events.filter(func(e):
		return e['duration_since'] <= duration || !e['dismissable']
	)
	print('Clearing events...')
	text = "\n".join(events.map(func(e):
		return e['text']
	))

func _prepend_event(event, dismissable = false):
	events.insert(0, {"text": event, "duration_since": 0, "dismissable": dismissable})
	text = "\n".join(events.map(func(e):
		return e['text']
	))
