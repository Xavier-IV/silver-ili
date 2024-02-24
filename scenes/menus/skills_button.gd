extends Button

@onready var list = preload("res://scenes/menus/panels/skills/skill_listings.tscn")
@onready var panel = %SkillsPanel


func _on_pressed():
	print("runing")
	panel._set_content(list)
	panel.section_name = "Skills v2"
	panel.visible = true
