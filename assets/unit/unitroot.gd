extends KinematicBody


var is_selected : bool = false

export (float, 0, 100, 0.5) var movement_speed = 5.0
export (Color) var basecolor = Color.blue setget set_basecolor, get_basecolor

onready var _ObjectTypeNode = get_node("%ObjectType")
onready var _NavAgentNode = get_node_or_null("%NavigationAgent")
onready var _NavMapNode = get_tree().get_root().get_node("./Main/World/WorldNavigation")
onready var UnitMesh = $MeshBody
onready var albedocolor:SpatialMaterial = UnitMesh.mesh.material
onready var shader:ShaderMaterial = UnitMesh.mesh.material.next_pass
onready var NavPoint = preload("res://assets/helper/navpoint.tscn")


func _ready():
	_ObjectTypeNode._ObjectType = Globals.OBJECT_TYPE_ENUM.TYPE_UNIT
	_ObjectTypeNode.UnitType = "UnitSoldierBase"
	_ObjectTypeNode.UnitName = "Basic Soldier"
	albedocolor.albedo_color = Color.blue
	if is_instance_valid(_NavAgentNode):
		_ObjectTypeNode._canmoveunit = false
		_NavAgentNode.set_target_location(global_transform.origin)
	
	# Object selektieren
	if not Signalbus.is_connected("objectselected", self, "_on_select_object"):
		var _sig = Signalbus.connect("objectselected", self, "_on_select_object")
	#		assert(sig == OK, "ObjectManager::init_signals() -> connect objectselected failed")

	# Objecte Selektion aufheben
	if not Signalbus.is_connected("objectunselected", self, "_on_unselect_object"):
		var _sig = Signalbus.connect("objectunselected", self, "_on_unselect_object")
	#		assert(sig == OK, "ObjectManager::init_signals() -> connect objunectselected failed")



func _physics_process(_delta):
	if _NavAgentNode.is_navigation_finished():
		return

	var targetpos = _NavAgentNode.get_next_location()
	var direction = global_transform.origin.direction_to(targetpos)
	var velocity = direction * movement_speed # _NavAgentNode.max_speed

	var lookdir = atan2(velocity.x, velocity.z)
	rotation.y = lookdir

	if _NavAgentNode.avoidance_enabled:
		_NavAgentNode.set_velocity(velocity)
	else:
		var _mas = move_and_slide(velocity, Vector3.UP)
	


# ===========================
# Select und Unselect des Buildings
func _on_select_object(id:int):
	# var thisid = get_instance_id()
	if id == get_instance_id():
		select_object(true)


func _on_unselect_object(id:int):
	if id == get_instance_id():
		select_object(false)



func _on_NavigationAgent_velocity_computed(_safe_velocity: Vector3) -> void:
	var _mas = move_and_slide(_safe_velocity, Vector3.UP)


func SetAgentTarget(newAgentTarget:Vector3)-> void:
	_NavAgentNode.set_target_location(newAgentTarget)


func can_objectselected() -> bool:
	return _ObjectTypeNode.can_selected()


func get_objecttype():
	return _ObjectTypeNode._ObjectType


func set_basecolor(value):
	basecolor = value
	albedocolor.albedo_color = value


func get_basecolor():
	return basecolor


func select_object(selected:bool) -> void:
	is_selected = selected
	if is_selected:
		shader.set_shader_param("strenght", 1.0)
	else:
		shader.set_shader_param("strenght", 0.0)


func _on_NavigationAgent_path_changed():
	var path = _NavAgentNode.get_nav_path()

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
	var path = _NavAgentNode.get_nav_path()

	if path.size() > 0:
		if Globals._WorldNavPointNodeParent.get_child_count() > 0:
			for c in Globals._WorldNavPointNodeParent.get_children():
				c.queue_free()


func _on_NavigationAgent_navigation_finished():
	pass
