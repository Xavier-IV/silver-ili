extends Control


func _ready():
	$FindJob.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_button_down():
	$FindJob.visible = !$FindJob.visible
	pass
