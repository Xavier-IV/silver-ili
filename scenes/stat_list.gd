extends HBoxContainer

@onready var reputation_global_stat = %ReputationGlobalStat
@onready var reputation_work_stat = %ReputationWorkStat


# Called when the node enters the scene tree for the first time.
func _ready():
	var reputation_message = "[b]Followers[/b]\n\n"
	reputation_message += "Your influence in your community and around the world. Higher reputation unlocks more opportunities and resources."
	reputation_global_stat.set_tooltip(reputation_message)

	var reputation_work_message = "[b]Work Reputation[/b]\n\n"
	reputation_work_message += "Your standing in the current job. Better reputation gives you more leverage and can affect your organization as a whole."
	reputation_work_stat.set_tooltip(reputation_work_message)
	GlobalStat.connect("sig_stats_changed", _on_stats_changed)
	_update()


func _on_stats_changed(stat_name):
	if stat_name != "global_reputation" and stat_name != "work_reputation":
		return
	_update()


func _update():
	reputation_global_stat._set_label(str(int(GlobalStat.stats["global_reputation"])))
	reputation_work_stat._set_label(str(int(GlobalStat.stats["work_reputation"])))
