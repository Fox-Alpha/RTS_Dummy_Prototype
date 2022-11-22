class_name ObjectManager
extends ManagerBase

# ===========================
# Manager der als Proxy zwischen interagierbaren Objekten steht
# Hier wird ermittelt welches Objekt eine AKtion ausführt
# und leitet diese weiter
# ===========================
#var GM:Node

var selected_object setget _set_selectedobject, _get_selectedobject
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

	# Objecte left clicked
	if not Signalbus.is_connected("objectleftclicked", self, "_on_leftclick_object"):
		var _sig = Signalbus.connect("objectleftclicked", self, "_on_leftclick_object")
#		assert(sig == OK, "ObjectManager::init_signals() -> connect objunectselected failed")

	# Objecte right clicked
	if not Signalbus.is_connected("objectrightclicked", self, "_on_rightclick_object"):
		var _sig = Signalbus.connect("objectrightclicked", self, "_on_rightclick_object")
#		assert(sig == OK, "ObjectManager::init_signals() -> connect objunectselected failed")


# ===========================
#Signal Methoden
# ===========================
# Signal ein Objekt deselektieren
func _on_unselect_object() -> void:
	if is_instance_valid(selected_object):
		selected_object.select_object(false)
		selected_object = null
		selected_object_type = Globals.OBJECT_TYPE_ENUM.TYPE_UNDEFINED


# Signal ein Objekt selektieren
func _on_select_object(_selectedobject) -> void:
	# print_debug("Signal selectobject received: ", _selectedobject)
	# var objtype = _selectedobject.get_objecttype()

	if is_instance_valid(selected_object):
		if selected_object != _selectedobject:
			Signalbus.emit_signal("objectunselected")

	selected_object = _selectedobject
	selected_object.select_object(true)
	# selected_object_type = objtype
	
	# print_debug("OM::_on_select_object() ->  Signal objectselected received")
	# match objtype:
		# Globals.OBJECT_TYPE_ENUM.TYPE_BUILDING:
			# print_debug("Object Type is BUILDING")
		# Globals.OBJECT_TYPE_ENUM.TYPE_UNIT:
			# print_debug("Object Type is UNIT")
		# Globals.OBJECT_TYPE_ENUM.TYPE_RESOURCE:
			# print_debug("Object Type is RESOURCE")
		# Globals.OBJECT_TYPE_ENUM.TYPE_GROUND:
			# print_debug("Object Type is GROUND")
		# Globals.OBJECT_TYPE_ENUM.TYPE_UNDEFINED:
			# print_debug("Object Type is UNDEFINED")


func _on_leftclick_object(objectid:int):
	var collider = instance_from_id(objectid)

	if !collider.has_method("get_objecttype"):
			collider = collider.get_parent_spatial()
	if is_instance_valid(collider):
		var cansel = collider.call("can_objectselected")
		if cansel:
			print_debug("GM::_select_object() ->  Signal objectselected emitted")
			Signalbus.emit_signal("objectselected", collider)
		else:
			Signalbus.emit_signal("objectunselected")#	pass


func _on_rightclick_object(objectid:int, clicked_position:Vector3):
	var collider = instance_from_id(objectid)

	if !collider.has_method("get_objecttype"):
		collider = collider.get_parent_spatial()
	if collider.get_instance_id() == Globals._instance.GroundNodeID:
		# CHGME: Aufruf einer Generalisierten Methode
		if is_instance_valid(selected_object) and selected_object.call("get_objecttype") == Globals.OBJECT_TYPE_ENUM.TYPE_UNIT:
			selected_object.SetAgentTarget(clicked_position)
		if is_instance_valid(selected_object) and selected_object.call("get_objecttype") == Globals.OBJECT_TYPE_ENUM.TYPE_BUILDING:
			selected_object.SetBuildingRallyPoint(clicked_position)

# ===========================

# ===========================
# Getter & Setter Methoden
# ===========================
func _set_selectedobject(value) -> void:
#	if value != value.empty():
	if is_instance_valid(value):
		selected_object = value


func _get_selectedobject():
	return selected_object
	pass
# ===========================


#func BuildNewObject(newType:int):
# func _on_instantiate_new_object(newType:int):
	# print_debug("OM: Neuen Typ erstellen: ", newType)
	
	# var objtype = selected_object.get_objecttype()
	# match objtype:
		# Globals.OBJECT_TYPE_ENUM.TYPE_BUILDING:
			# print_debug("BuildNewObject(): Object Type is Building")
			# var bm = GM.get_manager_instance("BuildingManager") <- Return Instance ID !!!
			# if is_instance_valid(bm):
				# bm.
		# Globals.OBJECT_TYPE_ENUM.TYPE_UNIT:
			# print_debug("BuildNewObject(): Object Type is UNIT")
		# Globals.OBJECT_TYPE_ENUM.TYPE_RESOURCE:
			# print_debug("BuildNewObject(): Object Type is RESOURCE")
		# Globals.OBJECT_TYPE_ENUM.TYPE_GROUND:
			# print_debug("BuildNewObject(): Object Type is GROUND")
		# Globals.OBJECT_TYPE_ENUM.TYPE_UNDEFINED:
			# print_debug("BuildNewObject(): Object Type is UNDEFINED")
	# pass
