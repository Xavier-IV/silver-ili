@tool
extends TextureRect

@export var label: String
@export var tooltip_text_override: String
@export var label_color: Color = Color(1, 1, 1, 1)


# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.text = label
	$Label.add_theme_color_override("font_color", label_color)


func _set_label(text: String):
	label = text
	$Label.text = label


func set_tooltip(text: String):
	tooltip_text_override = text


func _on_mouse_entered():
	var tooltip = preload("res://scenes/Tooltip.tscn")
	var tooltip_instance = tooltip.instantiate()

	tooltip_instance.set_tooltip_message(tooltip_text_override)
	add_child(tooltip_instance)
