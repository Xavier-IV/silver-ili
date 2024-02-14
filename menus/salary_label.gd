extends Label

var bouncing = false
var bouncing_speed = 10.0
var bounced_distance = 0
var original_position = Vector2(0, 0)


func _ready():
	GlobalSignal.connect("sig_apply_job", _on_apply_job)


func _on_apply_job(job):
	text = "Salary: RM " + str(job.salary)
