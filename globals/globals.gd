extends Node


enum OBJECT_TYPE_ENUM{
	TYPE_UNDEFINED,
	TYPE_BUILDING,
	TYPE_UNIT,
	TYPE_RESOURCE,
	TYPE_GROUND
}

# Globale GameManager Instanz
var _instance:GameManager setget set_gamemanager_instance, get_gamemanager_instance

#func _ready():
#	pass


func set_gamemanager_instance(_value):
#	if value != null && _instance == null:
#		_instance = value
	pass


func get_gamemanager_instance():
#	return _instance
	pass