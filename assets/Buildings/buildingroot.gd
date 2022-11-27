extends Spatial


onready var _ObjectTypeNode = get_node("%ObjectType")
onready var BuildingMesh = $BaracksBody/MeshBuilding
onready var shader:ShaderMaterial = BuildingMesh.mesh.material.next_pass

onready var unit = preload("res://assets/unit/unit.tscn")

onready var tween:Tween = Tween.new()

var ui_manager
var building_manager
var GM : Node

var progress
#: float = 0.0
# ===========================
# Build-In Methoden
# ===========================
#func _init():
#	pass


func _ready():
	shader = BuildingMesh.mesh.material.next_pass
		
	if not Signalbus.is_connected("game_manager_is_ready", self, "_on_game_manager_is_ready"):
		var _sig = Signalbus.connect("game_manager_is_ready", self, "_on_game_manager_is_ready")
		
	# Object selektieren
	if not Signalbus.is_connected("objectselected", self, "_on_select_object"):
		var _sig = Signalbus.connect("objectselected", self, "_on_select_object")
	#		assert(sig == OK, "ObjectManager::init_signals() -> connect objectselected failed")
	
	# Objecte Selektion aufheben
	if not Signalbus.is_connected("objectunselected", self, "_on_unselect_object"):
		var _sig = Signalbus.connect("objectunselected", self, "_on_unselect_object")
	#		assert(sig == OK, "ObjectManager::init_signals() -> connect objunectselected failed")

		
	if not Signalbus.is_connected("newobject_build_has_started", self, "_on_newobject_build_has_started"):
		var _sig = Signalbus.connect("newobject_build_has_started", self, "_on_newobject_build_has_started")

	if not Signalbus.is_connected("newobject_instantiated", self, "_on_instantiate_new_object"):
		var _sig = Signalbus.connect("newobject_instantiated", self, "_on_instantiate_new_object")


		# _on_Tween_tween_started			tween_started
		# _on_Tween_tween_step				tween_step
		# _on_Tween_tween_completed			tween_completed
		# _on_Tween_tween_all_completed		tween_all_completed
		
	if not tween.is_connected("tween_started", self, "_on_Tween_tween_started"):
		var _sig = tween.connect("tween_started", self, "_on_Tween_tween_started")

	if not tween.is_connected("tween_step", self, "_on_Tween_tween_step"):
		var _sig = tween.connect("tween_step", self, "_on_Tween_tween_step")

	if not tween.is_connected("tween_completed", self, "_on_Tween_tween_completed"):
		var _sig = tween.connect("tween_completed", self, "_on_Tween_tween_completed")

	if not tween.is_connected("tween_all_completed", self, "_on_Tween_tween_all_completed"):
		var _sig = tween.connect("tween_all_completed", self, "_on_Tween_tween_all_completed")
				

#func _enter_tree():
#	pass


#func _exit_tree():
#	pass

# MOVE: In den BuildinManager verschieben, Überwachen BuildQueue
# func _process(_delta):
# 	pass
	# BuildQueue abarbeiten
	# var id = get_instance_id()
	# if !_ObjectTypeNode._ObjectBuildQueue.empty(): # and !_ObjectTypeNode.is_building:
	# 	if _ObjectTypeNode.is_build_pending:
	# 		return

	# 	var nextUnitType = _ObjectTypeNode._ObjectBuildQueue.pop_front()
	# 	print_debug("Unit in Queue: ", nextUnitType, " / ", name)
	# 	Signalbus.emit_signal("newobject_instantiated", nextUnitType, id)
	# 	_ObjectTypeNode.is_building = true

# ===========================

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

# ===========================

func _on_game_manager_is_ready():
	GM = Globals.GMInstance
	
	if is_instance_valid(GM):
		print(name, "::on_game_manager_is_ready() -> ", name, " ( ", get_instance_id(), " )")
	
	# ADDME: Builöding im BuildinManager anmelden 
	building_manager = instance_from_id(GM.get_manager_instance("BuildingManager"))
	if is_instance_valid(building_manager):
		building_manager.add_building_to_manager(get_instance_id())


# MOVE: In den BuildinManager verschieben, Add To Queue
func _on_newobject_build_has_started(_newtype:int, Building_ID:int): # Node ID
	if get_instance_id() == Building_ID:
		var node_path = NodePath("progress")
		var property_path = node_path.get_as_property_path()
		print(property_path)

		if tween.interpolate_method(
		#if tween.interpolate_property(
			self, "tween_method", 0, 100,
			# var buildtime = _ObjectTypeNode.ObjectTypeProperties["ObjectsToSpawn"][String(newType)]["buildtime"]
			# buildtime aus properties
			5, Tween.TRANS_SINE, Tween.EASE_OUT
			):
			var _t = tween.start()


func tween_method():
	print("irgendwas")

	# pass
# 	pass
	# var thisid = get_instance_id()	# Vergleich der Instanz ID 

	#	einen Timer mit Buildtime starten
	# 	Während Timer den Fortschritt an das UI senden
	# 	Nach Timer beendigung Unit instanziieren


# func _on_newobject_tobuildqueue_added(nextType:int, Building_ID:int):
# 	var thisid = get_instance_id()
# 	if thisid == Building_ID:
# 		_ObjectTypeNode._ObjectBuildQueue.append(nextType)

# MOVEME: In den BuildingManager auslagern, hier nur Eigenschaften an Type anpassen und Position setzen
# TRYME: Methode in BaseClass implemetieren
# _on_newobject_build_has_started
func _on_instantiate_new_object(newType:int, Building_ID:int):
	var thisid = get_instance_id()
	if thisid != Building_ID:
		return

	# _ObjectTypeNode.is_build_pending = true
	var props = _ObjectTypeNode.ObjectTypeProperties
	if props.ObjectsToSpawn.has(String(newType)):
		
		var unitprops : Dictionary = _ObjectTypeNode.ObjectTypeProperties["ObjectsToSpawn"][String(newType)]
		var buildtime = _ObjectTypeNode.ObjectTypeProperties["ObjectsToSpawn"][String(newType)]["buildtime"]
		var newunit = unit.instance()

		var un = instance_from_id(GM.UnitsNodeID)
		if is_instance_valid(un):
			newunit.name = unitprops["name"]
			# yield(get_tree().create_timer(buildtime), "timeout")
			un.add_child(newunit)
			newunit.set_basecolor(unitprops["color"])
			# TRYME: Position und Agnent Target per Signal setzen
			newunit.set_global_translation(GetBuildingSpawnPos())
			newunit.SetAgentTarget(GetBuildingRallyPos())
		else: 
			newunit.queue_free()

	# _ObjectTypeNode.is_building = false
	# _ObjectTypeNode.is_build_pending = false


# ===========================
# Select und Unselect des Buildings
func _on_select_object(id:int):
	# var thisid = get_instance_id()
	if id == get_instance_id():
		select_object(true)


func _on_unselect_object(id:int):
	if id == get_instance_id():
		select_object(false)


func select_object(selected:bool) -> void:
	print_debug("BuildingRoot::select_object() -> Building selected: %s" % selected)
	_ObjectTypeNode.building_is_selected = selected
		# TRYME: Farbverlauf mit Tween ??
	if _ObjectTypeNode.building_is_selected:
		shader.set_shader_param("strenght", 1.0)

		if GetObjectHasUI():
			Signalbus.emit_signal("object_withui_selected", GetObjectUIName(), GetObjectProperties())
	else:
		shader.set_shader_param("strenght", 0.0)
		if GetObjectHasUI():
			Signalbus.emit_signal("object_withui_unselected", GetObjectUIName(), GetObjectUIId())


# ===========================
# _on_Tween_tween_started			tween_started
# _on_Tween_tween_step				tween_step
# _on_Tween_tween_completed			tween_completed
# _on_Tween_tween_all_completed		tween_all_completed

func _on_Tween_tween_started(_object: Object, _key: NodePath) -> void:
	pass

func _on_Tween_tween_step(_object:Object, _key:NodePath, _elapsed:float, _value:Object):
	# Update an UI senden
	pass

func _on_Tween_tween_completed() -> void:
	pass

func _on_Tween_tween_all_completed() -> void:
	pass

# 	is_building = false
	# tween.tell()

# ===========================

func GetObjectProperties() -> Dictionary:
	return _ObjectTypeNode.ObjectTypeProperties


func get_objecttype() -> int:
	return _ObjectTypeNode.BuildingObjectType


func GetObjectName() -> String:
	return _ObjectTypeNode.BuildingName


func GetObjectTypeName() -> String:
	return _ObjectTypeNode.BuildingTypeName


func can_objectselected() -> bool:
	var b = _ObjectTypeNode.BuildingCanSelect
	return b


func GetObjectHasUI() -> bool:
	return _ObjectTypeNode.BuildingHasUI


func GetObjectUIName() -> String:
	return _ObjectTypeNode.BuildingUiName


func GetObjectUIId() -> int:
	return _ObjectTypeNode.BuildingUI_ID


func GetObjectCanSpawnUnits() -> bool:
	return _ObjectTypeNode.BuildingCanSpawnUnits


func GetBuildingSpawnPos() -> Vector3:
	return _ObjectTypeNode.UnitSpawnPos


func GetBuildingRallyPos() -> Vector3:
	return _ObjectTypeNode.UnitRallyPos


func SetBuildingRallyPoint(pos:Vector3):
	_ObjectTypeNode.UnitRallyPos = pos

#####
