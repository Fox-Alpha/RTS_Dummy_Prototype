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

func _ready():
	if !Signalbus.is_connected("setgamemanagerinstance", self, "set_gamemanager_instance"):
		var sig = Signalbus.connect("setgamemanagerinstance", self, "set_gamemanager_instance")
		assert(sig == OK, "GLOBALS::_ready() - > Connect con set_gamemanager_instance fehlgeschlagen")
#	pass


func set_gamemanager_instance(value):
	if value != null && _instance == null && value != _instance:
		_instance = value
	pass


func get_gamemanager_instance():
	return _instance
	pass
