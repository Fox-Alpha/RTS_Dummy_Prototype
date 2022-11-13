class_name UIManager
extends ManagerBase


var _objectui_properties : Dictionary = {}
export var UserInterfaces : Dictionary = {}

onready var UINode : Node = get_tree().get_root().get_node_or_null("./Main/UI")

# ===========================
# Build-In Methoden
# ===========================
#func _init():
#	pass


func _ready():
	if is_instance_valid(UINode):
		var uinodes = UINode.get_children()
	
		if uinodes.size() > 0:
			for ui in uinodes:
				if is_instance_valid(ui):
					UserInterfaces[ui.name] = ui


#func _enter_tree():
#	pass


#func _exit_tree():
#	pass
# ===========================


# ===========================
#  public Methoden
# ===========================
func show_ui_instance(uiname:String, showui:bool, properties:Dictionary) -> void:
	if !uiname.empty():
		var ui = get_ui_instance(uiname)
		if (ui) != null:
			ui.visible = showui
			_objectui_properties = properties
#		pass


func get_ui_instance(ui : String) -> Control:
	if UserInterfaces.has(ui):
		return UserInterfaces[ui]
	return null
# ===========================
