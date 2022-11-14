extends BuildingBase
class_name Barracks


#var ObjectTypeProperties:Dictionary = {
#	"ObjectType": Globals.OBJECT_TYPE_ENUM.TYPE_BUILDING, 
#	"ObjectName": "EmptyName",
#	"ObjectTypeName": "EmptyTypeName",
#	"ObjectCanSelect": false,
#	"ObjectHasUI": false,
#	"ObjectUiName": "EmptyUI",
#	"ObjectCanSpawnObjects": false,
#	"ObjectSpawnPos": Vector3(),
#	"ObjectRallyPos": Vector3(),
#	"ObjectToSpawn": {}
#}


func _ready():
	_initobjectproperties()
#	pass


func _initobjectproperties():
	ObjectTypeProperties["ObjectType"] = Globals.OBJECT_TYPE_ENUM.TYPE_BUILDING
	ObjectTypeProperties["ObjectName"] = "Army Barrack"
	ObjectTypeProperties["ObjectTypeName"] = "BuildingArmyBarrack"
	ObjectTypeProperties["ObjectCanSelect"] = true
	ObjectTypeProperties["ObjectHasUI"] = true
	ObjectTypeProperties["ObjectUiName"] = "UI_Barracks"
	ObjectTypeProperties["ObjectCanSpawnObjects"] = true
	ObjectTypeProperties["ObjectSpawnPos"] = UnitSpawnPos
	ObjectTypeProperties["ObjectRallyPos"] = UnitRallyPos
	ObjectTypeProperties["ObjectsToSpawn"] = {
							"1": {
								"name": "",
								"class": "",
								"color": "",
								"__EMPTY_1": "",
								"__EMPTY_2": "",
							},
							"2": {
								"name": "",
								"class": "",
								"color": "",
								"__EMPTY_1": "",
								"__EMPTY_2": "",
							},
							"3": {
								"name": "",
								"class": "",
								"color": "",
								"__EMPTY_1": "",
								"__EMPTY_2": "",
							},
							"4": {
								"name": "",
								"class": "",
								"color": "",
								"__EMPTY_1": "",
								"__EMPTY_2": "",
							}
						}
#	ObjectTypeProperties[""] = ""
