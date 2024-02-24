extends GraphNode


# Called when the node enters the scene tree for the first time.
func _ready():
	set_slot(0, false, 1, Color.RED, true, 2, Color.RED)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
