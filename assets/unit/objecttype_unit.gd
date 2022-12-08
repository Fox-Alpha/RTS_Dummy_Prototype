class_name Unit
extends UnitBase


# ===========================
# Build-In Methoden
# ===========================
#func _init():
#	pass


func _ready():
	_initobjectproperties()


#func _enter_tree():
#	pass


#func _exit_tree():
#	pass
# ===========================

func _initobjectproperties():
	ObjectTypeProperties["ObjectParentName"] = _UnitRootNode.name
	ObjectTypeProperties["ObjectInstanceID"] = get_parent().get_instance_id()
	ObjectTypeProperties["ObjectType"] = Globals.OBJECT_TYPE_ENUM.TYPE_UNIT
	ObjectTypeProperties["ObjectName"] = "Army Soldier"
	ObjectTypeProperties["ObjectTypeName"] = "UnitArmySoldier"
	ObjectTypeProperties["ObjectCanSelect"] = true
	ObjectTypeProperties["ObjectHasUI"] = false
	ObjectTypeProperties["ObjectUI_ID"] = -1
	ObjectTypeProperties["ObjectUiName"] = "UI_Soldier"
	ObjectTypeProperties["ObjectCanSpawnObjects"] = false
	ObjectTypeProperties["ObjectSpawnPos"] = ""
	ObjectTypeProperties["ObjectRallyPos"] = ""
	ObjectTypeProperties["ObjectsToSpawn"] = {}
