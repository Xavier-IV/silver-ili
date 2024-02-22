@tool
extends PanelContainer

@export var section_name: String
@export var content: PackedScene


# Called when the node enters the scene tree for the first time.
func _ready():
	%PanelName.text = section_name
	mouse_filter = MOUSE_FILTER_STOP
	if content != null:
		var content_instance = content.instantiate()
		content_instance.size_flags_vertical = 3
		content_instance.size_flags_horizontal = 3
		%ContentContainer.add_child(content_instance)


func _on_close_button_pressed():
	visible = false
	var panelGroups = get_tree().get_nodes_in_group("PanelGroups")
	for panelGroup in panelGroups:
		if panelGroup != self:
			panelGroup.visible = false
	# free()
