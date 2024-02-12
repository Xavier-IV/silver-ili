extends Label

var events = []

func _extend_event():
	events.map(func(e):
		e['duration_since'] += 1
		return e
	)

func _clear_since(duration):
	events = events.filter(func(e):
		return e['duration_since'] <= duration
	)
	print('Clearing events...')
	text = "\n".join(events.map(func(e):
		return e['text']
	))

func _prepend_event(event):
	events.insert(0, {"text": event, "duration_since": 0})
	text = "\n".join(events.map(func(e):
		return e['text']
	))
