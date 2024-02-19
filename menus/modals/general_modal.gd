extends Control

@onready var title_label = %TitleLabel
@onready var content_text = %Content
@onready var button_group = %ButtonGroup
@onready var button = %Button


# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalModal.connect("sig_show_modal_dialog", _on_sig_show_modal_dialog)


func _on_sig_show_modal_dialog(title: String, message: String, buttons, callbacks):
	title_label.text = title
	content_text.text = message

	for index in buttons.size():
		var new_button = button.duplicate()
		new_button.text = buttons[index]
		if callbacks[index] != null:
			new_button.pressed.connect(callbacks[index])
		new_button.visible = true
		button_group.add_child(new_button)


func _on_button_pressed():
	GlobalModal.emit_signal("sig_close_modal")
	queue_free()
