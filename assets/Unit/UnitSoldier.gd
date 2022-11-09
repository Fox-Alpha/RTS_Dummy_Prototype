extends Node


onready var _ObjectTypeNode = get_node("%ObjectType")
onready var _NavAgentNode = get_node_or_null("%NavigationAgent")


func _ready():
	_ObjectTypeNode._ObjectType = Globals.OBJECT_TYPE_ENUM.TYPE_UNIT
	_ObjectTypeNode.UnitType = "UnitSoldierBase"
	_ObjectTypeNode.UnitName = "Basic Soldier"
	if _NavAgentNode == null:
		_ObjectTypeNode._canmoveunit = false
	pass


func _on_NavigationAgent_velocity_computed(safe_velocity: Vector3) -> void:
	pass # Replace with function body.


func SetAgentTarget(newAgentTarget:Vector3)-> void:
	print_debug("SetAgentTarget: %s" % newAgentTarget)
	_NavAgentNode.set_target_location(newAgentTarget)
