extends HBoxContainer

@onready var reputation_stat = %ReputationStat


# Called when the node enters the scene tree for the first time.
func _ready():
	var reputation_message = "[b]Global Reputation[/b]\n\n"
	reputation_message += "Your standing in your community and around the world. Higher reputation unlocks more opportunities and resources."
	reputation_stat.set_tooltip(reputation_message)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
