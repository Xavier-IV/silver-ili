extends TextureButton


# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalDateTime.connect("sig_pause_updated", _on_pause_updated)
	disabled = GlobalDateTime.is_paused()


func _on_pause_updated():
	if GlobalDateTime.is_paused():
		disabled = false
	else:
		disabled = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	GlobalDateTime.set_paused(false)
	disabled = true
