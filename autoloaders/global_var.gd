extends Node


func _ready():
	# GlobalSave.load()
	pass


var version = "v0.0.6"

var current_job = {}

var employment_detail = {
	"job_id": 0,
	"employer_name": "",
	"description": "",
	"role": "",
	"salary": 0.0,
	"start_date": "",
	"end_date": "",
	"status": "Pending",
	"working_days": [1, 2, 3, 4, 5],
	"working_hours": [9, 18],
}

# To break into tech, you need to have
# > Portfolio - Level 1
# > > Web - Level 1
# > >
var available_technologies = {
	"web":
	{
		"name": "Web",
		"require": [],
		"max_level": 3,
		"level":
		{
			1: {"time_cost": 1 * 24, "money_cost": 0, "mental_cost": 1},
			2: {"time_cost": 4 * 24, "money_cost": 500, "mental_cost": 5},
			3: {"time_cost": 10 * 24, "money_cost": 1000, "mental_cost": 8}
		}
	},
	"database":
	{
		"name": "Database",
		"require": [],
		"max_level": 3,
		"level":
		{
			1: {"time_cost": 1 * 24, "money_cost": 0, "mental_cost": 1},
			2: {"time_cost": 4 * 24, "money_cost": 500, "mental_cost": 5},
			3: {"time_cost": 10 * 24, "money_cost": 1000, "mental_cost": 8}
		}
	},
	"version_control":
	{
		"name": "Version Control",
		"require": [],
		"max_level": 3,
		"level":
		{
			1: {"time_cost": 1 * 24, "money_cost": 0, "mental_cost": 1},
			2: {"time_cost": 4 * 24, "money_cost": 500, "mental_cost": 5},
			3: {"time_cost": 10 * 24, "money_cost": 1000, "mental_cost": 8}
		}
	},
}

var jobs = {
	"1":
	{
		"id": "1",
		"name": "Mytax Sdn Bhd",
		"description": "Junior Level\n1 year experience",
		"salary": 3000,
		"requirement": ["Web"]
	},
	"2":
	{
		"id": "2",
		"name": "iBantu Enterprise",
		"description": "Fresh Graduate\nNo experience needed",
		"salary": 2000
	},
	"3":
	{
		"id": "3",
		"name": "Elegant Marketing Sdn Bhd",
		"description": "Senior Level\n4 years experience",
		"salary": 5000
	},
	"4":
	{
		"id": "4",
		"name": "TechNest Solutions",
		"description": "Junior Level\nNo experience needed\nLaravel,JQuery",
		"salary": 2000
	},
}


func employed():
	return current_job != {}


func get_skill_time_cost(skill, level):
	return float(available_technologies[skill]["level"][level]["time_cost"])


func get_skill_mental_cost(skill, level):
	return float(available_technologies[skill]["level"][level]["mental_cost"])
