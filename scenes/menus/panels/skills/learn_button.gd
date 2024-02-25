extends Button

@export var skill_key: String


# Called when the node enters the scene tree for the first time.
func _ready():
	pass  # Replace with function body.


func _set_skill_key(key: String):
	skill_key = key


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	Profile.set_learning(true)
	Profile.set_active_learning(skill_key)
	var panelGroups = get_tree().get_nodes_in_group("PanelGroups")
	for panelGroup in panelGroups:
		if panelGroup != self:
			panelGroup.visible = false
