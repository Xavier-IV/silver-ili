extends Node

signal sig_stats_changed(stat_name)
signal sig_stats_improved(stat_name, intensity)
signal sig_stats_deducted(stat_name, intensity)

var current_job = {}

var stats = {
	"mental_health": 100.0,
	"creativity_health": 100.0,
	"social_health": 100.0,
	"sleepiness": 0.0,
}

var buffer_stats = {}

var bed_sleeping_benefit = {
	"shaby_bed": 10.0,
	"normal_bed": 25.0,
	"good_bed": 40.0,
	"luxury_bed": 55.0,
}

var stat_ratio = {
	"mental_health": 3,
	"creativity_health": 1,
	"social_health": 1,
}


func get_mental_health():
	return stats["mental_health"]


func get_creativity_health():
	return stats["creativity_health"]


func get_social_health():
	return stats["social_health"]


func get_general_health():
	var total_health = stats.mental_health * 3 + stats.creativity_health + stats.social_health
	var max_health = 100 * 3 + 100 + 100

	total_health -= stats.sleepiness

	return float(total_health) / float(max_health) * 100


func begin_stat():
	buffer_stats = stats.duplicate(true)

	deduct_stat("social_health", 2)
	deduct_stat("creativity_health", 1)

	if GlobalVar.employed():
		improve_stat("social_health", 1)
		improve_stat("creativity_health", 0.5)
	pass


func conclude_stat():
	print("conclude harvesting stat")
	process_stat("mental_health")
	process_stat("social_health")
	process_stat("creativity_health")

	stats = buffer_stats.duplicate(true)
	pass


func get_intensity(value):
	var intensity = 1
	if float(value) <= 5:
		intensity = 1
	elif float(value) <= 20:
		intensity = 2
	else:
		intensity = 3

	return intensity


func process_stat(stat_name):
	var value = stats[stat_name] - buffer_stats[stat_name]

	if float(value) == 0.0:
		return

	if value < 0.0:
		emit_signal("sig_stats_improved", stat_name, get_intensity(value))
	elif value > 0.0:
		emit_signal("sig_stats_deducted", stat_name, get_intensity(value))

	emit_signal("sig_stats_changed", stat_name)


func deduct_stat(stat, value):
	buffer_stats[stat] -= float(value)

	if buffer_stats[stat] < 0:
		buffer_stats[stat] = 0


func deduct_stat_now(stat, value):
	stats[stat] -= float(value)

	if stats[stat] < 0:
		stats[stat] = 0

	emit_signal("sig_stats_deducted", stat, get_intensity(value))
	emit_signal("sig_stats_changed", stat)
	buffer_stats = stats.duplicate(true)


func improve_stat(stat, value):
	buffer_stats[stat] += float(value)

	if buffer_stats[stat] > 100:
		buffer_stats[stat] = 100


func improve_stat_now(stat, value):
	stats[stat] += float(value)

	if stats[stat] > 100:
		stats[stat] = 100

	emit_signal("sig_stats_improved", stat, get_intensity(value))
	emit_signal("sig_stats_changed", stat)
	buffer_stats = stats.duplicate(true)
