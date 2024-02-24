extends Control

@onready var v_box = %VBoxContainer
@onready var panel = %PanelContainer
@onready var skill_learned = %SkillLearned
@onready var skill_not_learned = %SkillNotLearned


# Called when the node enters the scene tree for the first time.
func _ready():
	for skill in GlobalVar.available_technologies.keys():
		var _panel = panel.duplicate()

		_panel.visible = true

		var _skill_level = _panel.get_node("MarginContainer/VBoxContainer/SkillLevel")
		var _skill_name = _panel.get_node("MarginContainer/VBoxContainer/SkillDetail/SkillName")
		var _skill_button = _panel.get_node("MarginContainer/VBoxContainer/SkillDetail/LearnButton")

		_skill_name.text = GlobalVar.available_technologies[skill].name
		_skill_button._set_skill_key(skill)
		for i in range(GlobalVar.available_technologies[skill].max_level):
			var _skill_learned = skill_learned.duplicate()
			var _skill_not_learned = skill_not_learned.duplicate()
			_skill_learned.visible = true
			_skill_not_learned.visible = true
			if Profile.learned_technologies.has(skill) && i < Profile.get_skill_level(skill):
				_skill_level.add_child(_skill_learned)
			else:
				_skill_level.add_child(_skill_not_learned)

		v_box.add_child(_panel)
