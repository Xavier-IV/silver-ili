extends Node

var salary = 0
var balance = 0


func _ready():
	GlobalSignal.connect("sig_apply_job", _on_apply_job)


func _on_apply_job(job):
	salary = job.salary