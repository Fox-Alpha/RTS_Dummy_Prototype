extends Node

enum OBJECT_TYPE_ENUM{
	TYPE_UNDEFINED,
	TYPE_BUILDING,
	TYPE_UNIT,
	TYPE_RESOURCE,
	TYPE_GROUND
}


# TODO: Add Signal für UnitsRootNode
# TODO: Add Signal für BuildingRootNode
# TODO: Add Signal für neue Gebäude
# TODO: Bei neuen Gebäuden die NavMesh neu berechnen


# Globale GameManager Instanz
# CHGME: getter und setter als private
var GMInstance:GameManager setget _set_gamemanager_instance, _get_gamemanager_instance

onready var _WorldNavPointNodeParent = get_tree().get_root().get_node("./Main/World/NavPoints")

func _ready():
	if !Signalbus.is_connected("setgamemanagerinstance", self, "_set_gamemanager_instance"):
		var _sig = Signalbus.connect("setgamemanagerinstance", self, "_set_gamemanager_instance")

	if !Signalbus.is_connected("scene_end_reached", self, "_on_scene_end_reached"):
		var _sig = Signalbus.connect("scene_end_reached", self, "_on_scene_end_reached")


func _on_scene_end_reached():
	if is_instance_valid(GMInstance):
		Signalbus.emit_signal("game_manager_is_ready")


func _set_gamemanager_instance(value):
	if value != null && GMInstance == null && value != GMInstance:
		GMInstance = value


func _get_gamemanager_instance():
	return GMInstance
