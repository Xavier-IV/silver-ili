extends VBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func list_jobs(jobs):
	var job_item = load("res://menus/job_item.tscn")

	for job in jobs:
		var job_item_instance = job_item.instantiate()
		job_item_instance.set_detail(job["name"], job["description"])
		add_child(job_item_instance)
