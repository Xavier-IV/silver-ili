extends Node

signal sig_saving_game
signal sig_saving_complete

signal sig_loading_game


func save():
	print("Saving game...")
	emit_signal("sig_saving_game")
	var global_employment = {
		"current": GlobalVar.current_job, "detail": GlobalVar.employment_detail
	}
	var global_datetime = GlobalDateTime.current
	var global_stat = GlobalStat.stats
	var global_buffer_stat = GlobalStat.buffer_stats
	var global_cashflows = {
		"salary": GlobalCashflow.salary,
		"balance": GlobalCashflow.balance,
		"expenses": GlobalCashflow.expenses,
		"overdue": GlobalCashflow.overdue
	}
	var global_event = GlobalEvent.events

	var save_game = FileAccess.open("user://savegame.save", FileAccess.WRITE)

	var json_string = JSON.stringify(
		{
			"global_employment": global_employment.duplicate(),
			"global_datetime": global_datetime.duplicate(),
			"global_cashflows": global_cashflows.duplicate(),
			"global_stat": global_stat.duplicate(),
			"global_buffer_stat": global_buffer_stat.duplicate(),
			"global_event": global_event.duplicate()
		}
	)

	# Store the save dictionary as a new line in the save file.
	save_game.store_line(json_string)
	emit_signal("sig_saving_complete")


func load():
	print("Loading game...use a lot resource")
	if not FileAccess.file_exists("user://savegame.save"):
		return  # Error! We don't have a save to load.

	var save_game = FileAccess.open("user://savegame.save", FileAccess.READ)
	while save_game.get_position() < save_game.get_length():
		var json_string = save_game.get_line()

		# Creates the helper class to interact with JSON
		var json = JSON.new()
		var parse_result = json.parse(json_string)
		if not parse_result == OK:
			print(
				"JSON Parse Error: ",
				json.get_error_message(),
				" in ",
				json_string,
				" at line ",
				json.get_error_line()
			)
			continue
		var node_data = json.data
		print(node_data["global_employment"])
		GlobalVar.current_job = node_data["global_employment"]["current"]
		GlobalVar.employment_detail = node_data["global_employment"]["detail"]

		GlobalDateTime.current = node_data["global_datetime"]

		GlobalCashflow.salary = node_data["global_cashflows"]["salary"]
		GlobalCashflow.balance = node_data["global_cashflows"]["balance"]
		GlobalCashflow.expenses = node_data["global_cashflows"]["expenses"]
		GlobalCashflow.overdue = node_data["global_cashflows"]["overdue"]

		if node_data.has("global_event"):
			GlobalEvent.events = node_data["global_event"]

		if node_data.has("global_stat"):
			GlobalStat.stats = node_data["global_stat"]

		if node_data.has("global_buffer_stat"):
			GlobalStat.buffer_stats = node_data["global_buffer_stat"]
