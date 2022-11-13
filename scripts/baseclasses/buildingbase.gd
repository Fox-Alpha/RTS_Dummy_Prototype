extends Node
class_name BuildingBase


export var _buildingname : String = "EmptyName" setget set_building_name,get_building_name
export var _buildingtype : String = "EmptyType" setget set_building_type,get_building_type
export var _buildinguiname : String = "EmptyUI" setget set_building_uiname,get_building_uiname
export var _ObjectType:int = Globals.OBJECT_TYPE_ENUM.TYPE_BUILDING setget _set_objecttype, get_objecttype
export var _buildingcanspawnunits : bool = false
export var _buildinghasui : bool = false


var ObjectTypeProperties:Dictionary = {
	"BuildingName": "EmptyName",
	"BuildingType": "EmptyType",
	"ObjectType": Globals.OBJECT_TYPE_ENUM.TYPE_BUILDING, 
	"BuildingHasUI": false,
	"BuildingUiName": "EmptyUI",
	"BuildingCanSpawnObjects": false,
	"ObjectSpawnPos": Vector3(),
	"UnitRallyPos": Vector3(),
	"ObjectsToSpawn": {}
}


#onready var GM = Globals.get_gamemanager_instance()
onready var BuildingRootNode = get_parent()
onready var _ObjectTypeNode = get_node("%ObjectType")

onready var UnitSpawnNode = .get_node_or_null("%UnitSpawnPosition3D")
onready var UnitRallypointNode = .get_node_or_null("%UnitRallyPosition3D")

var UnitSpawnPos : Vector3 setget set_building_spawnpoint, get_building_spawnpoint
var UnitRallyPos : Vector3 setget set_building_rallypoint, get_building_rallypoint


# ===========================
# Build-In Methoden
# ===========================
#func _init():
#	pass


func _ready():
	if ObjectTypeProperties["BuildingCanSpawnObjects"]:
		if is_instance_valid(UnitSpawnNode) and is_instance_valid(UnitRallypointNode):
			UnitSpawnPos = .get_node("%UnitSpawnPosition3D").get_global_translation()
			UnitRallyPos = .get_node("%UnitRallyPosition3D").get_global_translation()


#func _enter_tree():
#	pass


#func _exit_tree():
#	pass
# ===========================


func _set_objecttype(value):
	ObjectTypeProperties["ObjectType"] = value


func get_objecttype():
	return ObjectTypeProperties["ObjectType"]

# ===========================

func set_building_spawnpoint(value):
	ObjectTypeProperties["UnitSpawnPos"] = value


func get_building_spawnpoint():
	return ObjectTypeProperties["UnitSpawnPos"]

# ===========================

func set_building_rallypoint(newrallypoint):
	ObjectTypeProperties["UnitRallyPos"] = newrallypoint
	if is_instance_valid(UnitRallypointNode):
		UnitRallypointNode.set_global_translation(newrallypoint)


func get_building_rallypoint() -> Vector3:
	return ObjectTypeProperties["UnitRallyPos"]

# ===========================

func set_building_name(value:String) -> void:
	if value != _buildingname and not value.empty():
		ObjectTypeProperties["BuildingName"] = value


func get_building_name() -> String:
	return ObjectTypeProperties["BuildingName"]

# ===========================

func set_building_type(value:String) -> void:
	if value != _buildingtype and not value.empty():
		_buildingtype = value


func get_building_type() -> String:
	return _buildingtype

# ===========================

func set_building_uiname(value:String):
	if !value.empty():
		ObjectTypeProperties["BuildingUiName"] = value
#	pass


func get_building_uiname() -> String:
	return ObjectTypeProperties["BuildingUiName"]
#	pass

# ===========================

