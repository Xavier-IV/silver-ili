@tool
extends GraphNode

var is_editing = true


# Called when the node enters the scene tree for the first time.
func _ready():
	set_slot(0, false, 1, Color.RED, true, 1, Color.PURPLE)
	set_slot(1, false, 1, Color.RED, true, 1, Color.PURPLE)
	is_editing = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
