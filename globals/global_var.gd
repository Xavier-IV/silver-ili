extends Node

var current_job = {}

var employment_detail = {
	"job_id": 0,
	"employer_name": "",
	"description": "",
	"role": "",
	"salary": 0,
	"start_date": "",
	"end_date": "",
	"status": "Pending",
	"working_days": [1, 2, 3, 4, 5],
	"working_hours": [9, 18],
}

var jobs = {
	"1":
	{
		"id": "1",
		"name": "Mytax Sdn Bhd",
		"description": "Junior Level\n1 year experience",
		"salary": 3000
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
