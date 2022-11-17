extends Spatial


onready var _ObjectTypeNode = get_node("%ObjectType")
onready var BuildingMesh = $BaracksBody/MeshBuilding
onready var shader:ShaderMaterial = BuildingMesh.mesh.material.next_pass

onready var unit = preload("res://assets/unit/unit.tscn")

var ui_manager
var GM : Node


# ===========================
# Build-In Methoden
# ===========================
#func _init():
#	pass


func _ready():
	shader = BuildingMesh.mesh.material.next_pass
	
	GM = Globals.get_gamemanager_instance()
	if not Signalbus.is_connected("newobject_instantiated", self, "_on_instantiate_new_object"):
		var _sig = Signalbus.connect("newobject_instantiated", self, "_on_instantiate_new_object")
	
	if !Signalbus.is_connected("game_manager_is_ready", self, "on_game_manager_is_ready"):
		var _sig = Signalbus.connect("game_manager_is_ready", self, "on_game_manager_is_ready")
		
	if !Signalbus.is_connected("add_newobject_tobuildqueue", self, "on_newobject_tobuildqueue_added"):
		var _sig = Signalbus.connect("add_newobject_tobuildqueue", self, "on_newobject_tobuildqueue_added")
		
	if !Signalbus.is_connected("newobject_build_has_started", self, "on_newobject_build_has_started"):
		var _sig = Signalbus.connect("newobject_build_has_started", self, "on_newobject_build_has_started")


func _enter_tree():
#	GM = Globals.get_gamemanager_instance()
#
#	if is_instance_valid(GM):
#		print(name, "::on_game_manager_is_ready() -> ", name)
	pass


#func _exit_tree():
#	pass


func _process(_delta):
	# BuildQueue abarbeiten
	# FIXME: Abfrage zu schnell ???
	if !_ObjectTypeNode._ObjectBuildQueue.empty():
		var nextUnitType = _ObjectTypeNode._ObjectBuildQueue.pop_front()
		print_debug("Unit in Queue: ", nextUnitType, " / ", name)
		# CHGME: Erkennungsmerkmal für BUILDING wird benötigt
		# FIXME: Nur in einer BUILDING instanz herstellen
#		Signalbus.emit_signal("newobject_instantiated", nextUnitType)
#	else: 
#		return
# ===========================
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
# ===========================
func on_game_manager_is_ready():
	GM = Globals.get_gamemanager_instance()
	
	if is_instance_valid(GM):
		print(name, "::on_game_manager_is_ready() -> ", name)


func on_newobject_build_has_started(): # Node ?
	# CHGME: Erkennungsmerkmal für BUILDING wird benötigt
	_ObjectTypeNode.is_building = true

func on_newobject_tobuildqueue_added(nextType:int):
	# CHGME: Erkennungsmerkmal für BUILDING wird benötigt
	_ObjectTypeNode._ObjectBuildQueue.append(nextType)


func _on_instantiate_new_object(newType:int):
#	print_debug("OM: Neuen Typ erstellen: ", newType)
	# TODO: Anpassen an Buildqueue
#	if _ObjectTypeNode.is_building: # or _ObjectTypeNode._ObjectBuildQueue.empty():
#		return

	# FIXME: Es werden 4 Objecte gespawnt
	# CHGME: Erkennungsmerkmal für BUILDING wird benötigt
	var props = _ObjectTypeNode.ObjectTypeProperties
	if props.ObjectsToSpawn.has(String(newType)):
		
		var unitprops : Dictionary = _ObjectTypeNode.ObjectTypeProperties["ObjectsToSpawn"][String(newType)]
		print_debug("Buildingroot: Neuen Typ erstellen: ", newType)
		var newunit = unit.instance()
		GM.UnitsNode.add_child(newunit)
		newunit.name = unitprops["name"]
		newunit.set_basecolor(unitprops["color"])
		newunit.set_global_translation(GetBuildingSpawnPos())
		newunit.SetAgentTarget(GetBuildingRallyPos())
		
	_ObjectTypeNode.is_building = false


func _manage_ui(showui:bool):
	if !is_instance_valid(ui_manager):
		ui_manager = GM.get_manager_instance("UIManager")

	if is_instance_valid(ui_manager):
		if GetObjectHasUI():
			ui_manager.show_ui_instance(GetObjectUIName(), showui, GetObjectProperties())


func select_object(selected:bool) -> void:
	print_debug("BuildingRoot::select_object() -> Building selected: %s" % selected)
	_ObjectTypeNode.building_is_selected = selected
	if _ObjectTypeNode.building_is_selected:
		shader.set_shader_param("strenght", 1.0)
		# DONE: UI Anzeigen lassen
		_manage_ui(true)
	else:
		shader.set_shader_param("strenght", 0.0)
		# DONE: UI Ausblenden lassen
		_manage_ui(false)


func GetObjectProperties() -> Dictionary:
	return _ObjectTypeNode.ObjectTypeProperties

func get_objecttype() -> int:
	return _ObjectTypeNode.BuildingObjectType

func GetObjectName() -> String:
	return _ObjectTypeNode.BuildingName


func GetObjectTypeName() -> String:
	return _ObjectTypeNode.BuildingTypeName


# func GetBuildingCanSelect() -> bool:
func can_objectselected() -> bool:
	var b = _ObjectTypeNode.BuildingCanSelect
	return b


func GetObjectHasUI() -> bool:
	return _ObjectTypeNode.BuildingHasUI


func GetObjectUIName() -> String:
	return _ObjectTypeNode.BuildingUiName


func GetObjectCanSpawnUnits() -> bool:
	return _ObjectTypeNode.BuildingCanSpawnUnits


func GetBuildingSpawnPos() -> Vector3:
	return _ObjectTypeNode.UnitSpawnPos


func GetBuildingRallyPos() -> Vector3:
	return _ObjectTypeNode.UnitRallyPos


func SetBuildingRallyPoint(pos:Vector3):
	_ObjectTypeNode.UnitRallyPos = pos

#####
