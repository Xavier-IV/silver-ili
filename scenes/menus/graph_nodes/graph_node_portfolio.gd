extends GraphNode


# Called when the node enters the scene tree for the first time.
func _ready():
	set_slot(0, true, 1, Color.PURPLE, false, 1, Color.PURPLE)
	set_slot(1, true, 2, Color.RED, false, 1, Color.PURPLE)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
