class_name ObjectManager
extends ManagerBase

# ===========================
# Manager der als Proxy zwischen interagierbaren Objekten steht
# Hier wird ermittelt welches Objekt eine AKtion ausführt
# und leitet diese weiter
# ===========================

var selected_object setget _set_selectedobject, _get_selectedobject
var selected_object_type = Globals.OBJECT_TYPE_ENUM.TYPE_UNDEFINED

# ===========================


# ===========================
# Build-In Methoden
# ===========================
#func _init():
#	pass


func _ready():
	_init_signals()


#func _enter_tree():
#	pass


#func _exit_tree():
#	pass

# ===========================


# ===========================
# Signals
# ===========================
func _init_signals() -> void:
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

func _on_leftclick_object(objectid:int):
	var collider = instance_from_id(objectid)

	if !collider.has_method("get_objecttype"):
			collider = collider.get_parent_spatial()
			objectid = collider.get_instance_id()
	
	if is_instance_valid(collider):
		if selected_object != collider and selected_object != null:
			Signalbus.emit_signal("objectunselected", selected_object.get_instance_id())
			selected_object = null
			selected_object_type = Globals.OBJECT_TYPE_ENUM.TYPE_UNDEFINED

		selected_object = collider
		
		selected_object_type = selected_object.call("get_objecttype")
		
		Signalbus.emit_signal("objectselected", objectid)


func _on_rightclick_object(objectid:int, clicked_position:Vector3):
	var collider = instance_from_id(objectid)

	if !collider.has_method("get_objecttype"):
		collider = collider.get_parent_spatial()
	if collider.get_instance_id() == Globals.GMInstance.GroundNodeID:
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
	if is_instance_valid(value):
		selected_object = value


func _get_selectedobject():
	return selected_object

# ===========================


# REFACTOR: _on_instantiate_new_object
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
