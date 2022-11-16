class_name UIManager
extends ManagerBase


var _objectui_properties : Dictionary setget _set_objectui_properties, _get_objectui_properties
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
		if is_instance_valid(ui):
			_objectui_properties = properties
			ui.visible = showui
#		pass


func get_ui_instance(ui : String) -> Control:
	if UserInterfaces.has(ui):
		return UserInterfaces[ui]
	return null
# ===========================
func _set_objectui_properties(value:Dictionary):
	if _objectui_properties.hash() != value.hash():
		_objectui_properties = value
#	pass


func  _get_objectui_properties():
	return _objectui_properties
#	pass
