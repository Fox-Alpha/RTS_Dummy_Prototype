class_name ObjectManager
extends ManagerBase
#extends Node

# ===========================
# Manager der als Proxy zwischen interagierbaren Objekten steht
# Hier wird ermittelt welches Objekt eine AKtion ausführt
# und leitet diese weiter
# ===========================

var GMInstance setget set_gamemanagerinstance, _get_gamemanagerinstance

var selected_object setget set_selectedobject, get_selectedobject


enum OBJECT_TYPE_ENUM{
	TYPE_UNDEFINED,
	TYPE_BUILDING,
	TYPE_UNIT,
	TYPE_RESOURCE
}

# ===========================
func _init():
	print("ObjectManager::_init() -> Created")
#	if !is_connected("objectselected", self, "_on_select_object"):
#		var conn = connect("objectselected", self, "_on_select_object")
#		assert(conn, "Connect von Signal objectselected gescheitert")
#	if !is_connected("objectunselected", self, "_on_unselect_object"):
#		var conn = connect("objectunselected", self, "_on_unselect_object")
#		assert(conn, "Connect von Signal objectunselected gescheitert")
	pass


func set_gamemanagerinstance(value) -> void: 
#	print_debug(value)
	if value != null: 
		GMInstance = value
	pass


func _get_gamemanagerinstance():
	return GMInstance
	pass


# func _ready():
# 	pass


#func _enter_tree():
#	pass


#func _exit_tree():
#	pass

# ===========================
# Signals
# ===========================
func init_signals() -> void:
	if not Signalbus.is_connected("objectselected", self, "_on_select_object"):
		var sig = Signalbus.connect("objectselected", self, "_on_select_object")
		print_debug(sig)
		assert(sig == OK, "ObjectManager::init_signals() -> connect objectselected failed")
	if not Signalbus.is_connected("objectunselected", self, "_on_unselect_object"):
		var sig = Signalbus.connect("objectunselected", self, "_on_unselect_object")
		print_debug(sig)
		assert(sig == OK, "ObjectManager::init_signals() -> connect objunectselected failed")
#	pass


# ===========================
# Signal ein Objekt deselektieren
func _on_unselect_object() -> void:
	if selected_object != null:
		selected_object.select_building(false)
# TODO: ObjectTyp ermitteln, Selektiertes aktives Objekt Selection aufheben, Selection in Object deaktivieren
	pass


# Signal ein Objekt selektieren
func _on_select_object(_selectedobject) -> void:
	print_debug("Signal selectobject emitted: ", _selectedobject)
	var objtype = _selectedobject.get_objecttype()
	
	match objtype:
		OBJECT_TYPE_ENUM.TYPE_BUILDING:
			print_debug("Object Type is BUILDING")
		OBJECT_TYPE_ENUM.TYPE_UNIT:
			print_debug("Object Type is UNIT")
		OBJECT_TYPE_ENUM.TYPE_RESOURCE:
			print_debug("Object Type is RESOURCE")
		OBJECT_TYPE_ENUM.TYPE_UNDEFINED:
			print_debug("Object Type is UNDEFINED")
	
	if !selected_object != null or selected_object != _selectedobject:
			Signalbus.emit_signal("objectunselected")
	
	selected_object = _selectedobject
	selected_object.select_building(true)
#	if objtype != null:
#		objtype.
# TODO: ObjectTyp ermitteln, aktives selectiertes Object setzen, Selection in Object aktivieren
	pass
# ===========================

# ===========================
#set_selectedobject, get_selectedobject
func set_selectedobject(value) -> void:
	if value != value.empty():
		selected_object = value


func get_selectedobject():
	return selected_object

# ===========================
