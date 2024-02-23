@tool
extends Button

@export_enum("sm", "nm", "lg", "xl") var _size: String = "nm"
@export var _text: String = "Button"

var MARGIN = {
	"sm": [8, 4, 8, 4],
	"nm": [10, 5, 10, 5],
	"lg": [20, 10, 20, 10],
	"xl": [30, 15, 30, 15],
}

var RADIUS = {"sm": 2, "nm": 4, "lg": 10, "xl": 15}


# Called when the node enters the scene tree for the first time.
func _ready():
	text = _text


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	for _style in ["normal", "hover", "pressed", "disabled"]:
		var stylebox: StyleBox = get_theme_stylebox(_style).duplicate()
		stylebox.content_margin_left = MARGIN[_size][0]
		stylebox.content_margin_top = MARGIN[_size][1]
		stylebox.content_margin_right = MARGIN[_size][2]
		stylebox.content_margin_bottom = MARGIN[_size][3]

		stylebox.set_corner_radius_all(RADIUS[_size])
		add_theme_stylebox_override(_style, stylebox)
