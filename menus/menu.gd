extends Control


func _ready():
	$PrimeContainer/SideControl/FindJob.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_button_button_down():
	$PrimeContainer/SideControl/FindJob.visible = !$PrimeContainer/SideControl/FindJob.visible
	pass
