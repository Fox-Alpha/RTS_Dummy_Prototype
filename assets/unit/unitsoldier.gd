extends KinematicBody


var is_selected : bool = false

export (float, 0, 100, 0.5) var movement_speed = 5.0

onready var _ObjectTypeNode = get_node("%ObjectType")
onready var _NavAgentNode = get_node_or_null("%NavigationAgent")
onready var _NavMapNode = get_tree().get_root().get_node("./Main/World/WorldNavigation")
#onready var _NavPointNodeParent = get_tree().get_root().get_node("./Main/World/NavPoints")
onready var UnitMesh = $MeshBody
onready var shader:ShaderMaterial = UnitMesh.mesh.material.next_pass
onready var NavPoint = preload("res://assets/helper/navpoint.tscn")


func _ready():
	_ObjectTypeNode._ObjectType = Globals.OBJECT_TYPE_ENUM.TYPE_UNIT
	_ObjectTypeNode.UnitType = "UnitSoldierBase"
	_ObjectTypeNode.UnitName = "Basic Soldier"
	if _NavAgentNode == null:
		_ObjectTypeNode._canmoveunit = false
	_NavAgentNode.set_target_location(global_transform.origin)


func _physics_process(_delta):
	if _NavAgentNode.is_navigation_finished():
		return

	var targetpos = _NavAgentNode.get_next_location()
	var direction = global_transform.origin.direction_to(targetpos)
	var velocity = direction * movement_speed # _NavAgentNode.max_speed

#	look_at(global_transform.origin, -targetpos)
	#_from_position

	var lookdir = atan2(velocity.x, velocity.z)
	rotation.y = lookdir

	if _NavAgentNode.avoidance_enabled:
		_NavAgentNode.set_velocity(velocity)
	else:
		move_and_slide(velocity, Vector3.UP)
	


func _on_NavigationAgent_velocity_computed(_safe_velocity: Vector3) -> void:
# warning-ignore:unused_variable
	var mas = move_and_slide(_safe_velocity, Vector3.UP)


func SetAgentTarget(newAgentTarget:Vector3)-> void:
	print_debug("SetAgentTarget: %s" % newAgentTarget)
	_NavAgentNode.set_target_location(newAgentTarget)


func can_objectselected() -> bool:
	return _ObjectTypeNode.can_selected()


func get_objecttype():
	return _ObjectTypeNode._ObjectType


func select_object(selected:bool) -> void:
	print_debug("UnitRoot::select_object() -> Unit selected: %s" % selected)
	is_selected = selected
	if is_selected:
		shader.set_shader_param("strenght", 1.0)
	else:
		shader.set_shader_param("strenght", 0.0)


func _on_NavigationAgent_path_changed():
	var path = _NavAgentNode.get_nav_path()

#	DONE: Dummy für Nav Punkte erstellen
	if path.size() > 0:
		if Globals._WorldNavPointNodeParent.get_child_count() > 0:
			for c in Globals._WorldNavPointNodeParent.get_children():
				c.queue_free()
		for p in path:
			var nav = NavPoint.instance()
			nav.translate(p)
			nav.scale_object_local(Vector3(0.5, 0.5, 0.5))
			Globals._WorldNavPointNodeParent.add_child(nav)


func _on_NavigationAgent_target_reached():
	print_debug("_on_NavigationAgent_target_reached()")
	var path = _NavAgentNode.get_nav_path()

#	DONE: Dummy für Nav Punkte erstellen
	if path.size() > 0:
		if Globals._WorldNavPointNodeParent.get_child_count() > 0:
			for c in Globals._WorldNavPointNodeParent.get_children():
				c.queue_free()


func _on_NavigationAgent_navigation_finished():
	print_debug("_on_NavigationAgent_navigation_finished()")
