extends ProgressBar


func _ready():
	GlobalStat.connect("sig_stats_changed", _on_stats_changed)
	_on_stats_changed('mental_health')


func _on_stats_changed(_stat_name):
	value = GlobalStat.get_mental_health()
