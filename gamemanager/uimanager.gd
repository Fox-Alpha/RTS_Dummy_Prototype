class_name UIManager
extends Node

export var UserInterfaces : Dictionary = {}
var GM : Node

onready var UINode : Node = get_tree().get_root().get_node_or_null("./Main/UI")

func _init():
	print("UIManager::_init() -> Created")
#	pass


func _ready():
	if is_instance_valid(UINode):
		var uinodes = UINode.get_children()
	
		if uinodes.size() > 0:
			for ui in uinodes:
				if is_instance_valid(ui):
					UserInterfaces[ui.name] = ui
#	pass


#func _enter_tree():
#	pass


#func _exit_tree():
#	pass

########################
func show_ui_building(building : String, showui:bool) -> void:
	if !building.empty():
		var b = get_ui_instance(building)
		if (b) != null:
			b.visible = showui
#		pass


func get_ui_instance(ui : String) -> Control:
	if UserInterfaces.has(ui):
		return UserInterfaces[ui]
	return null


func SetGameManagerInstance():
	GM = Globals.get_gamemanager_instance()
