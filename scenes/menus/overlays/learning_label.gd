extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	Profile.connect("sig_start_learning", _on_start_learning)
	Profile.connect("sig_continuous_learning", _on_start_learning)
	Profile.connect("sig_done_learning", _on_done_learning)


func _on_done_learning():
	self.text = "Done!"


func _on_start_learning():
	self.text = (
		"Learning %s - %s..." % [Profile.current_learning, Profile.get_current_percentage_padded()]
	)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
