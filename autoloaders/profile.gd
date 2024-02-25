extends Node

signal sig_start_learning
signal sig_continuous_learning
signal sig_done_learning

var is_learning = false

var default = {
	"current_level": 0,
	"current_time_spent": 0,
}

var learned_technologies = {
	"web":
	{
		"current_level": 0,
		"current_time_spent": 0,
	},
	"database":
	{
		"current_level": 0,
		"current_time_spent": 0,
	}
}

var current_learning = ""


func get_current_percentage_padded():
	var tech = learned_technologies.get(current_learning, default)
	if current_learning == "":
		return "00%"
	else:
		return get_skill_percentage_padded(current_learning, tech["current_level"] + 1)


func get_skill_level(skill):
	var tech = learned_technologies.get(skill, default)
	return float(tech["current_level"])


func get_skill_time_spent(skill):
	var tech = learned_technologies.get(skill, default)
	return float(tech["current_time_spent"])


func get_skill_time_spent_overall(skill, level):
	return get_skill_time_spent(skill) / GlobalVar.get_skill_time_cost(skill, level)


func get_skill_time_spent_overall_percentage(skill, level):
	return get_skill_time_spent_overall(skill, level) * 100


func get_skill_percentage_padded(skill, level):
	return str(int(get_skill_time_spent_overall_percentage(skill, level))).pad_zeros(2) + "%"


func set_learning(value):
	is_learning = value


func set_active_learning(skill):
	current_learning = skill
	emit_signal("sig_start_learning")


func continuous_learning():
	if not is_learning:
		return

	var _notification = GlobalSignal.Notification.new()

	if GlobalStat.get_mental_health() < 50:
		is_learning = false
		emit_signal("sig_done_learning")
		print("Mental health is too low to continue learning")
		_notification.text = "Uh-oh! I can't cope with learning right now. I need to rest."
		_notification.duration = 1.0

		GlobalSignal.emit_signal("sig_notify", _notification)
		return

	_notification.text = "[color=#2083cb](Mental-)[/color] [color=#4e505d]Learning skills...[/color]"
	_notification.duration = 1.0

	GlobalSignal.emit_signal("sig_notify_stat", _notification)

	emit_signal("sig_continuous_learning")

	learned_technologies[current_learning] = learned_technologies.get(current_learning, default)
	learned_technologies[current_learning]["current_time_spent"] += 1

	var current_level = learned_technologies[current_learning]["current_level"]
	var current_time_spent = learned_technologies[current_learning]["current_time_spent"]
	var mental_cost = GlobalVar.get_skill_mental_cost(current_learning, current_level + 1)

	GlobalStat.deduct_stat_now("mental_health", mental_cost)

	if current_time_spent <= GlobalVar.get_skill_time_cost(current_learning, current_level + 1):
		pass
	else:
		learned_technologies[current_learning]["current_level"] += 1
		learned_technologies[current_learning]["current_time_spent"] = 0
		is_learning = false
		emit_signal("sig_done_learning")
		pass


func stop_learning(skill):
	is_learning = false
