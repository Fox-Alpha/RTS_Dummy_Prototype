extends Spatial


export var _canselectground : bool = false
onready var _ObjectTypeNode = get_node("%ObjectType")


func _ready():
	_ObjectTypeNode._ObjectType = Globals.OBJECT_TYPE_ENUM.TYPE_GROUND
	if !Signalbus.is_connected("game_manager_is_ready", self, "_on_game_manager_is_ready"):
		var _sig = Signalbus.connect("game_manager_is_ready", self, "_on_game_manager_is_ready")
	pass


func can_objectselected() -> bool:
	return _canselectground


func get_objecttype_node() -> Node:
	return _ObjectTypeNode


func get_objecttype():
	return _ObjectTypeNode._ObjectType


func _on_game_manager_is_ready():
	# TODO: Node instance ID im GameManager (?? WorldManager) anmelden
	# TODO: Eigener Verweis auf GameManager bei bedarf erstellen
	Globals._instance.GroundNodeID = get_instance_id()
	pass
