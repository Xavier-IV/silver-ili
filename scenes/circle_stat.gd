@tool
extends TextureRect

@export var label: String
@export var tooltip_text_override: String


# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.text = label


func set_tooltip(text: String):
	tooltip_text_override = text


func _on_mouse_entered():
	var tooltip = preload("res://scenes/Tooltip.tscn")
	var tooltip_instance = tooltip.instantiate()

	tooltip_instance.set_tooltip_message(tooltip_text_override)
	add_child(tooltip_instance)
