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
	
	if not Signalbus.is_connected("newobject_instantiated", self, "_on_instantiate_new_object"):
		var _sig = Signalbus.connect("newobject_instantiated", self, "_on_instantiate_new_object")
	
	if !Signalbus.is_connected("game_manager_is_ready", self, "_on_game_manager_is_ready"):
		var _sig = Signalbus.connect("game_manager_is_ready", self, "_on_game_manager_is_ready")
		
	if !Signalbus.is_connected("add_newobject_tobuildqueue", self, "_on_newobject_tobuildqueue_added"):
		var _sig = Signalbus.connect("add_newobject_tobuildqueue", self, "_on_newobject_tobuildqueue_added")
		
	if !Signalbus.is_connected("newobject_build_has_started", self, "_on_newobject_build_has_started"):
		var _sig = Signalbus.connect("newobject_build_has_started", self, "on_newobject_build_has_started")


#func _enter_tree():
#	pass


#func _exit_tree():
#	pass


func _process(_delta):
	# BuildQueue abarbeiten
	var id = get_instance_id()
	if !_ObjectTypeNode._ObjectBuildQueue.empty(): # and !_ObjectTypeNode.is_building:
		if _ObjectTypeNode.is_build_pending:
			return

		var nextUnitType = _ObjectTypeNode._ObjectBuildQueue.pop_front()
		print_debug("Unit in Queue: ", nextUnitType, " / ", name)
		Signalbus.emit_signal("newobject_instantiated", nextUnitType, id)
		_ObjectTypeNode.is_building = true

# ===========================

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

# ===========================

func _on_game_manager_is_ready():
	GM = Globals.GMInstance
	
	if is_instance_valid(GM):
		print(name, "::on_game_manager_is_ready() -> ", name, " ( ", get_instance_id(), " )")


func _on_newobject_build_has_started(_Building_ID:int): # Node ID
	pass
	# var thisid = get_instance_id()
	# if thisid == Building_ID:
	# 	_ObjectTypeNode.is_build_pending = true


func _on_newobject_tobuildqueue_added(nextType:int, Building_ID:int):
	var thisid = get_instance_id()
	if thisid == Building_ID:
		_ObjectTypeNode._ObjectBuildQueue.append(nextType)


func _on_instantiate_new_object(newType:int, Building_ID:int):
	var thisid = get_instance_id()
	if thisid != Building_ID:
		return

	_ObjectTypeNode.is_build_pending = true
	var props = _ObjectTypeNode.ObjectTypeProperties
	if props.ObjectsToSpawn.has(String(newType)):
		
		var unitprops : Dictionary = _ObjectTypeNode.ObjectTypeProperties["ObjectsToSpawn"][String(newType)]
		var buildtime = _ObjectTypeNode.ObjectTypeProperties["ObjectsToSpawn"][String(newType)]["buildtime"]
		var newunit = unit.instance()

		var un = instance_from_id(GM.UnitsNodeID)
		if is_instance_valid(un):
			newunit.name = unitprops["name"]
			yield(get_tree().create_timer(buildtime), "timeout")
			un.add_child(newunit)
			newunit.set_basecolor(unitprops["color"])
			newunit.set_global_translation(GetBuildingSpawnPos())
			newunit.SetAgentTarget(GetBuildingRallyPos())
		else: 
			newunit.queue_free()

	_ObjectTypeNode.is_building = false
	_ObjectTypeNode.is_build_pending = false


func _manage_ui(showui:bool):
	if !is_instance_valid(ui_manager):
		var ui_manager_id = GM.get_manager_instance("UIManager")
		if ui_manager_id > 0:
			ui_manager = instance_from_id(ui_manager_id)

	if is_instance_valid(ui_manager):
		if GetObjectHasUI():
			ui_manager.show_ui_instance(GetObjectUIName(), showui, GetObjectProperties())


func select_object(selected:bool) -> void:
	print_debug("BuildingRoot::select_object() -> Building selected: %s" % selected)
	_ObjectTypeNode.building_is_selected = selected
		# TRYME: Farbverlauf mit Tween ??
	if _ObjectTypeNode.building_is_selected:
		shader.set_shader_param("strenght", 1.0)
		_manage_ui(true)
	else:
		shader.set_shader_param("strenght", 0.0)
		_manage_ui(false)


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


func GetObjectCanSpawnUnits() -> bool:
	return _ObjectTypeNode.BuildingCanSpawnUnits


func GetBuildingSpawnPos() -> Vector3:
	return _ObjectTypeNode.UnitSpawnPos


func GetBuildingRallyPos() -> Vector3:
	return _ObjectTypeNode.UnitRallyPos


func SetBuildingRallyPoint(pos:Vector3):
	_ObjectTypeNode.UnitRallyPos = pos

#####
