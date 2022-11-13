extends BuildingBase
class_name Barracks


#var ObjectTypeProperties:Dictionary = {
#	"BuildingName": "EmptyName",
#	"BuildingType": "EmptyType",
#	"ObjectType": Globals.OBJECT_TYPE_ENUM.TYPE_BUILDING, 
#	"BuildingHasUI": false,
#	"BuildingUiName": "EmptyUI",
#	"BuildingCanSpawnObjects": false,
#	"ObjectSpawnPos": Vector3(),
#	"UnitRallyPos": Vector3(),
#	"ObjectsToSpawn": {}
#}


func _ready():
	_initobjectproperties()
#	pass


func _initobjectproperties():
	ObjectTypeProperties["BuildingName"] = "Army Barrack"
	ObjectTypeProperties["BuildingType"] = "BuildingArmyBarrack"
	ObjectTypeProperties["ObjectType"] = Globals.OBJECT_TYPE_ENUM.TYPE_BUILDING
	ObjectTypeProperties["BuildingHasUI"] = true
	ObjectTypeProperties["BuildingUiName"] = "UI_Barracks"
	ObjectTypeProperties["BuildingCanSpawnObjects"] = true
	ObjectTypeProperties["ObjectSpawnPos"] = UnitSpawnPos
	ObjectTypeProperties["UnitRallyPos"] = UnitRallyPos
	ObjectTypeProperties["ObjectsToSpawn"] = {}
#	ObjectTypeProperties[""] = ""
