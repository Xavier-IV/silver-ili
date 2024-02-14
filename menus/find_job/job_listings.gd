extends VBoxContainer

var job_item = load("res://menus/find_job/job_item.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	for job in GlobalVar.jobs.values():
		var job_item_instance = job_item.instantiate()
		job_item_instance.set_detail(job)
		add_child(job_item_instance)
