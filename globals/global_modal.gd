extends Node

signal sig_show_modal_dialog(title: String, message: String, buttons, callback)
signal sig_close_modal(title: String)

@onready var modal = preload("res://menus/modals/GeneralModal.tscn")


func init_modal(parent, title, description, buttons, callbacks):
	print("initiating")
	var modal_instance = modal.instantiate()
	parent.add_child(modal_instance)

	GlobalModal.emit_signal("sig_show_modal_dialog", title, description, buttons, callbacks)
