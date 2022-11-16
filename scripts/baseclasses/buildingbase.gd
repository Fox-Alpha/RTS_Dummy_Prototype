extends Node
class_name BuildingBase

var building_is_selected:bool setget _set_building_is_selected, _get_building_is_selected 

var BuildingObjectType:int setget _set_objecttype, _get_objecttype # OBJECT_TYPE_ENUM.TYPE_*
var BuildingName : String setget _set_building_name, _get_building_name
var BuildingTypeName : String setget _set_building_typename, _get_building_typename
var BuildingCanSelect : bool setget _set_building_can_select, _get_building_can_select
var BuildingHasUI : bool setget _set_buildinghasui, _get_buildinghasui
var BuildingUiName : String setget _set_building_uiname, _get_building_uiname
var BuildingCanSpawnUnits : bool setget _set_canspawnunits, _get_canspawnunits
var UnitSpawnPos : Vector3 setget _set_building_spawnpoint, _get_building_spawnpoint
var UnitRallyPos : Vector3 setget _set_building_rallypoint, _get_building_rallypoint
# "ObjectsToSpawn": {}


var ObjectTypeProperties : Dictionary setget , _Get_ObjectTypeProperties


#onready var GM = Globals.get_gamemanager_instance()
onready var _BuildingRootNode = get_parent()
onready var _ObjectTypeNode = get_node("%ObjectType")

onready var _UnitSpawnNode = .get_node_or_null("%UnitSpawnPosition3D")
onready var _UnitRallypointNode = .get_node_or_null("%UnitRallyPosition3D")


# TODO: Warteschlange integrieren
# TODO: Warteschlange von UI abrufen
# TODO: Warteschlange continuirlich prüfen und abarbeiten, auch wenn nicht mehr selektiert / kein UI

# ===========================
# Build-In Methoden
# ===========================
#func _init():
#	pass


func _ready():
	ObjectTypeProperties = {
		"ObjectType": Globals.OBJECT_TYPE_ENUM.TYPE_BUILDING, 
		"ObjectName": "EmptyName",
		"ObjectTypeName": "EmptyTypeName",
		"ObjectCanSelect": false,
		"ObjectHasUI": false,
		"ObjectUiName": "EmptyUI",
		"ObjectCanSpawnObjects": false,
		"ObjectSpawnPos": Vector3(),
		"ObjectRallyPos": Vector3(),
		"ObjectsToSpawn": {}
	}
	UnitSpawnPos = _UnitSpawnNode.get_global_translation()
	UnitRallyPos = _UnitRallypointNode.get_global_translation()
#	pass
	
	
#	if _Get_ObjectTypeProperty("ObjectCanSpawnObjects"):
#		if is_instance_valid(_UnitSpawnNode) and is_instance_valid(_UnitRallypointNode):
#			UnitSpawnPos = _UnitSpawnNode.get_global_translation()
#			UnitRallyPos = _UnitRallypointNode.get_global_translation()
#_UnitSpawnNode) and is_instance_valid(_UnitRallypointNode):
#			UnitSpawnPos = .get_node("%UnitSpawnPosition3D").get_global_translation()
#			UnitRallyPos = .get_node("%UnitRallyPosition3D").get_global_translation()


#func _enter_tree():
#	pass


#func _exit_tree():
#	pass
# ===========================

# ===========================

func _set_building_is_selected(value:bool):
	building_is_selected = value


func  _get_building_is_selected():
	return building_is_selected

# ===========================


# ===========================

func _Set_ObjectTypeProperty(property, value) -> void:
	if ObjectTypeProperties.has(property):
		ObjectTypeProperties[property] = value


func _Get_ObjectTypeProperty(property:String):
	var prop
	if ObjectTypeProperties.has(property):
		prop = ObjectTypeProperties[property]
		# 
	return prop
	


# Abfrage des gesamten Property Dictionary
func _Get_ObjectTypeProperties() -> Dictionary:
	return ObjectTypeProperties

# ===========================

func _set_objecttype(value:int):
	_Set_ObjectTypeProperty("ObjectType", value)


func _get_objecttype() -> int:
	return _Get_ObjectTypeProperty("ObjectType")

# ===========================

func _set_building_name(value:String) -> void:
	if value != BuildingName and not value.empty():
		_Set_ObjectTypeProperty("ObjectName", value)


func _get_building_name() -> String:
	return _Get_ObjectTypeProperty("ObjectName")

# ===========================

func _set_building_typename(value:String) -> void:
	if not value.empty():
		_Set_ObjectTypeProperty("ObjectTypeName", value)


func _get_building_typename() -> String:
	return _Get_ObjectTypeProperty("ObjectTypeName")

# ===========================

func _set_building_can_select(value):
	_Set_ObjectTypeProperty("ObjectCanSelect", value)


func _get_building_can_select():
	return _Get_ObjectTypeProperty("ObjectCanSelect")

# ===========================

func _set_buildinghasui(value):
	_Set_ObjectTypeProperty("ObjectHasUI", value)
	
func _get_buildinghasui():
	return _Get_ObjectTypeProperty("ObjectHasUI")

# ===========================

func _set_building_uiname(value:String):
	if !value.empty():
		_Set_ObjectTypeProperty("ObjectUiName", value)


func _get_building_uiname() -> String:
	return _Get_ObjectTypeProperty("ObjectUiName")

# ===========================

func  _set_canspawnunits(value):
	_Set_ObjectTypeProperty("ObjectCanSpawnObjects", value)


func _get_canspawnunits():
	return _Get_ObjectTypeProperty("ObjectCanSpawnObjects")

# ===========================

func _set_building_spawnpoint(value):
	_Set_ObjectTypeProperty("ObjectSpawnPos", value)


func _get_building_spawnpoint():
	return _Get_ObjectTypeProperty("ObjectSpawnPos")

# ===========================
# Set Rally Point
func _set_building_rallypoint(newrallypoint):
	_Set_ObjectTypeProperty("ObjectRallyPos", newrallypoint)
	if is_instance_valid(_UnitRallypointNode):
		_UnitRallypointNode.set_global_translation(newrallypoint)


func _get_building_rallypoint() -> Vector3:
#	var rp  = _Get_ObjectTypeProperty("ObjectRallyPos")
#	return rp
	return _Get_ObjectTypeProperty("ObjectRallyPos")

# ===========================

