extends Node

var events = {"onboarding": false}


func completed_event(event_name):
	return events[event_name]


func complete_event(event_name):
	events[event_name] = true
