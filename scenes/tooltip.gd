extends RichTextLabel

var GAP = 20


# Called when the node enters the scene tree for the first time.
func _ready():
	visible = true
	get_parent().mouse_exited.connect(_on_mouse_exited)
	get_parent().gui_input.connect(_on_gui_input)
	text = get_parent().tooltip_text_override


func set_tooltip_message(message):
	text = message


func _on_mouse_exited():
	print("exit")
	queue_free()


func _on_gui_input(event):
	if event is InputEventMouseMotion:
		var pos = event.global_position
		pos.x += 50.0
		pos.y += 30.0

		var tooltipSize = get_size()
		var viewportX = get_viewport_extreme("x")
		var viewportY = get_viewport_extreme("y")

		pos.x = clamp(pos.x, viewportX[0] + GAP, viewportX[1] - tooltipSize.x - GAP)
		pos.y = clamp(pos.y, viewportY[0] + GAP, viewportY[1] - tooltipSize.y - GAP)

		global_position = pos


func get_viewport_extreme(axis):
	var viewport = get_viewport()
	var _min = viewport.get_visible_rect().position[axis]
	var _max = _min + viewport.get_visible_rect().size[axis]
	return [_min, _max]
