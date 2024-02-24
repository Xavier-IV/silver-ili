extends GraphEdit

var GAP_X = 100
var GAP_Y = 20

var valid_nodes = {
	"Basic Portfolio":
	{
		"Development": 0,
	},
	"Development":
	{
		"Web": 0,
		"Database": 1,
	}
}

var completed_nodes = {}

var required_skills = ["web", "database"]

var player_skill_levels = {}
var required_skill_levels = {
	"web": 1,
	"database": 1,
}

var nodes = {
	"Basic Portfolio":
	{
		"order": [0, 0],
		"name": "Basic Portfolio",
		"skills": null,
		"skill_lvl_requirement": 0,
		"child_nodes":
		[
			{
				"name": "Development",
				"enabled": false,
				"connection": [true, 1, Color.LAWN_GREEN, false, 0, Color.GREEN]
			}
		]
	},
	"Development":
	{
		"order": [1, 0],
		"name": "Development",
		"skills": null,
		"skill_lvl_requirement": 0,
		"child_nodes":
		[
			{
				"name": "[LV01] Web",
				"enabled": true,
				"connection": [true, 2, Color.ORANGE_RED, false, 1, Color.GREEN]
			},
			{
				"name": "[LV01] Database",
				"enabled": true,
				"connection": [true, 3, Color.DEEP_SKY_BLUE, false, 2, Color.GREEN]
			},
			{
				"name": "Output",
				"enabled": false,
				"connection": [false, 1, Color(51, 102, 71, 1), true, 1, Color.LAWN_GREEN]
			}
		]
	},
	"Web":
	{
		"order": [2, 0],
		"name": "Web",
		"skills": "web",
		"skill_lvl_requirement": 1,
		"child_nodes":
		[
			{
				"name": "Level 1",
				"enabled": true,
				"connection": [false, 1, Color(51, 102, 71, 1), true, 2, Color.ORANGE_RED]
			}
		]
	},
	"Database":
	{
		"order": [2, 1],
		"name": "Database",
		"skills": "database",
		"skill_lvl_requirement": 1,
		"child_nodes":
		[
			{
				"name": "Level 1",
				"enabled": true,
				"connection": [false, 1, Color.GREEN, true, 3, Color.DEEP_SKY_BLUE]
			}
		]
	},
}

var all_nodes = []
var output_achieved = false
var node_paths = {}


# Called when the node enters the scene tree for the first time.
func _ready():
	# add_valid_connection_type(1, 1)
	connect("connection_request", _on_connection_request)
	connect("disconnection_request", _on_disconnection_request)
	var viewport = get_viewport()
	%Button.disabled = true
	var last_node = null
	var last_order = [0, 0]

	for need_skill in required_skills:
		player_skill_levels[need_skill] = Profile.get_skill_level(need_skill)

	for node in nodes.values():
		var order = node.order
		var player_skill = Profile.get_skill_level(node.skills)

		var skill_ready = player_skill >= node.skill_lvl_requirement

		if last_order[0] != order[0]:
			last_order = [0, 0]
		var graph_node = GraphNode.new()
		graph_node.title = node.name

		if node.skills != null:
			if skill_ready:
				graph_node.title += " (Learned)"
			else:
				graph_node.title += " (Not Yet Learned)"

		graph_node.name = node.name
		graph_node.custom_minimum_size = Vector2(300, 200)
		graph_node.draggable = false

		for child_i in range(node.child_nodes.size()):
			var child = node.child_nodes[child_i]
			var connection = child.connection
			var label = Label.new()
			label.text = child.name
			(
				graph_node
				. set_slot(
					child_i,
					connection[0],
					-1 if node.skills != null && !skill_ready else connection[1],
					Color.GRAY if node.skills != null && !skill_ready else connection[2],
					connection[3],
					-1 if node.skills != null && !skill_ready else connection[4],
					Color.GRAY if node.skills != null && !skill_ready else connection[5],
				)
			)
			graph_node.add_child(label)

		add_child(graph_node)
		all_nodes.append({"name": node.name, "node": graph_node})
		node_paths[graph_node.name] = graph_node.get_path()
		if last_node:
			if order[0] == last_order[0] && order[1] != last_order[1]:
				graph_node.position_offset = Vector2(
					last_node.position_offset.x,
					last_node.position_offset.y + (last_node.get_rect().size.y + GAP_Y)
				)
			else:
				graph_node.position_offset = Vector2(
					last_node.position_offset.x - last_node.get_rect().size.x - GAP_X,
					last_node.position_offset.y
				)
				last_node = graph_node
		else:
			graph_node.position_offset = Vector2(
				viewport.position.x / 2 - graph_node.get_rect().size.x / 2,
				viewport.position.y / 2 - graph_node.get_rect().size.y / 2
			)
			last_node = graph_node

		last_order = order
	# zoom = 1.3
	get_invalids()


func _on_connection_request(from_node, from_port, to_node, to_port):
	# print("Connection request from " + from_node + " to " + to_node)
	set_connection_activity(from_node, from_port, to_node, to_port, 1.0)
	connect_node(from_node, from_port, to_node, to_port)
	recalculate_validity()
	get_invalids()


func _on_disconnection_request(from_node, from_port, to_node, to_port):
	print("Disconnection request from " + from_node + " to " + to_node)
	disconnect_node(from_node, from_port, to_node, to_port)
	recalculate_disconnect(from_node, to_node)
	get_invalids()


func _on_button_pressed():
	pass


func recalculate_disconnect(from_node_name, to_node_name):
	pass


func recalculate_validity():
	completed_nodes = {}
	for node in get_connection_list():
		var from_node_name = str(node["from_node"])
		var to_node_name = str(node["to_node"])

		completed_nodes[node["to_node"]] = completed_nodes.get(to_node_name, {})
		completed_nodes[node["to_node"]][from_node_name] = node["to_port"]


func get_invalids():
	print(completed_nodes)
	print(valid_nodes)
	%Label.text = "Valid" if completed_nodes == valid_nodes else "Invalid"
	%Button.disabled = completed_nodes != valid_nodes
