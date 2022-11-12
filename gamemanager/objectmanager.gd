class_name ObjectManager
extends ManagerBase

# ===========================
# Manager der als Proxy zwischen interagierbaren Objekten steht
# Hier wird ermittelt welches Objekt eine AKtion ausführt
# und leitet diese weiter
# ===========================
#var GM:Node

var selected_object setget set_selectedobject, get_selectedobject
var selected_object_type = Globals.OBJECT_TYPE_ENUM.TYPE_UNDEFINED
# ===========================


# ===========================
# Build-In Methoden
# ===========================
#func _init():
#	pass


#func _ready():
#	pass


#func _enter_tree():
#	pass


#func _exit_tree():
#	pass
# ===========================


# ===========================
# Signals
# ===========================
func init_signals() -> void:
	# Object selektieren
	if not Signalbus.is_connected("objectselected", self, "_on_select_object"):
		var _sig = Signalbus.connect("objectselected", self, "_on_select_object")
#		assert(sig == OK, "ObjectManager::init_signals() -> connect objectselected failed")

	# Objecte Selektion aufheben
	if not Signalbus.is_connected("objectunselected", self, "_on_unselect_object"):
		var _sig = Signalbus.connect("objectunselected", self, "_on_unselect_object")
#		assert(sig == OK, "ObjectManager::init_signals() -> connect objunectselected failed")
#	pass


# ===========================
#Signal Methoden
# ===========================
# Signal ein Objekt deselektieren
func _on_unselect_object() -> void:
	if is_instance_valid(selected_object):

			var uim = GM.get_manager_instance("UIManager")
			if selected_object.has_method("GetObjectHasUI"):
				if is_instance_valid(uim):
					if selected_object.call("GetObjectHasUI"):
						uim.show_ui_building(selected_object.GetObjectUIName(), false)
					
			selected_object.select_object(false)
			selected_object = null
			selected_object_type = Globals.OBJECT_TYPE_ENUM.TYPE_UNDEFINED
		
		# TODO: UI Ausblenden falls vorhanden, Building, Unit


# Signal ein Objekt selektieren
func _on_select_object(_selectedobject) -> void:
	print_debug("Signal selectobject received: ", _selectedobject)
	var objtype = _selectedobject.get_objecttype()

	if is_instance_valid(selected_object):
		if selected_object != _selectedobject:
			Signalbus.emit_signal("objectunselected")

	selected_object = _selectedobject
	selected_object.select_object(true)
	selected_object_type = objtype
	
	print_debug("MM::_on_select_object() ->  Signal objectselected received")
	match objtype:
		Globals.OBJECT_TYPE_ENUM.TYPE_BUILDING:
			print_debug("Object Type is BUILDING")
			# TODO: UI Anzeigen
			var uim = GM.get_manager_instance("UIManager")
			if is_instance_valid(uim):
				if _selectedobject.GetObjectHasUI():
					uim.show_ui_building(_selectedobject.GetObjectUIName(), true)
		Globals.OBJECT_TYPE_ENUM.TYPE_UNIT:
			print_debug("Object Type is UNIT")
		Globals.OBJECT_TYPE_ENUM.TYPE_RESOURCE:
			print_debug("Object Type is RESOURCE")
		Globals.OBJECT_TYPE_ENUM.TYPE_GROUND:
			print_debug("Object Type is GROUND")
		Globals.OBJECT_TYPE_ENUM.TYPE_UNDEFINED:
			print_debug("Object Type is UNDEFINED")

# ===========================

# ===========================
# Getter & Setter Methoden
# ===========================
func set_selectedobject(value) -> void:
#	if value != value.empty():
	if is_instance_valid(value):
		selected_object = value


func get_selectedobject():
	return selected_object
	pass
# ===========================

