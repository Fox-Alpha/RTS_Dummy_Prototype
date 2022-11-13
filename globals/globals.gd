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

onready var _WorldNavPointNodeParent = get_tree().get_root().get_node("./Main/World/NavPoints")

func _ready():
	if !Signalbus.is_connected("setgamemanagerinstance", self, "set_gamemanager_instance"):
		var _sig = Signalbus.connect("setgamemanagerinstance", self, "set_gamemanager_instance")

	if !Signalbus.is_connected("game_manager_is_ready", self, "on_game_manager_is_ready"):
		var _sig = Signalbus.connect("game_manager_is_ready", self, "on_game_manager_is_ready")
#		assert(sig == OK, "GLOBALS::_ready() - > Connect on_game_manager_is_ready fehlgeschlagen")
#	pass

func on_game_manager_is_ready():
	var gm = get_gamemanager_instance()
	if is_instance_valid(gm):
		gm.BroadCastGM()
	pass
	
func set_gamemanager_instance(value):
	if value != null && _instance == null && value != _instance:
		_instance = value
		Signalbus.emit_signal("game_manager_is_ready")
	pass


func get_gamemanager_instance():
	return _instance
	pass
