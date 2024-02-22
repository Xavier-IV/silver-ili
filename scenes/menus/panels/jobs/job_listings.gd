extends ScrollContainer

@onready var job_item = preload("res://scenes/menus/find_job/job_item.tscn")
@onready var listing = $VBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	print("FindJobMenu ready")
	print(GlobalVar.jobs)
	print(listing)
	for job in GlobalVar.jobs.values():
		var job_item_instance = job_item.instantiate()
		job_item_instance.set_detail(job)
		listing.add_child(job_item_instance)
