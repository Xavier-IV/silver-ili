extends Label

@onready var parent = get_parent().get_parent().get_parent()


# Called when the node enters the scene tree for the first time.
func _ready():
	add_theme_color_override("font_color", parent.progress_label_color)

	text = parent.progress_label_text

	GlobalStat.connect("sig_stats_improved", _on_stats_improved)
	GlobalStat.connect("sig_stats_deducted", _on_stats_deducted)


func _on_stats_improved(stat_name, intensity):
	if stat_name != parent.progress_stat_name:
		return
	text = "+".repeat(intensity)


func _on_stats_deducted(stat_name, intensity):
	if stat_name != parent.progress_stat_name:
		return
	text = "-".repeat(intensity)
