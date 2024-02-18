extends Control

@export var progress_stat_name: String

@export var progress_label_text = "+"
@export var progress_label_color: Color

@export var progress_bar_color: Color
@export var progress_bar_radius: int = 15
@export var progress_value: float = 100


# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalStat.connect("sig_stats_improved", _on_stats_improved)
	GlobalStat.connect("sig_stats_deducted", _on_stats_deducted)


func _on_stats_improved(stat_name, _intensity):
	if stat_name != progress_stat_name:
		return
	$AnimationPlayer.play("adjusted")


func _on_stats_deducted(stat_name, _intensity):
	if stat_name != progress_stat_name:
		return
	$AnimationPlayer.play("adjusted")
