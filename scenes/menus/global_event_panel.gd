extends VBoxContainer

@onready var animation_player = %AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalSignal.connect("sig_show_global_event", _on_show_global_event)
	GlobalSignal.connect("sig_hide_global_event", _on_hide_global_event)


func _on_show_global_event(_event):
	animation_player.play("animate_event")


func _on_hide_global_event():
	animation_player.play_backwards("animate_event")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
