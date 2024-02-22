extends ProgressBar

@export_multiline var tooltip_text_override: String


func _ready():
	GlobalStat.connect("sig_stats_changed", _on_stats_changed)
	_on_stats_changed("general_health")


func _on_stats_changed(_stat_name):
	value = GlobalStat.get_general_health()


func _on_mouse_entered():
	var tooltip = preload("res://scenes/Tooltip.tscn")
	var tooltip_instance = tooltip.instantiate()

	var tooltip_msg = (
		"[b]General Health[/b]"
		+ "\n\nYour health is affected by your:"
		+ "\n\t[color=#2083cb]Mental %s [/color]"
		+ "\n\t[color=#d122bf]Creativity %s [/color]"
		+ "\n\t[color=#9ad056]Social %s [/color]"
	)

	tooltip_text_override = (
		tooltip_msg
		% [
			str(int(GlobalStat.get_mental_health())).pad_zeros(2),
			str(int(GlobalStat.get_creativity_health())).pad_zeros(2),
			str(int(GlobalStat.get_social_health())).pad_zeros(2)
		]
	)

	tooltip_instance.set_tooltip_message(tooltip_text_override)
	add_child(tooltip_instance)
