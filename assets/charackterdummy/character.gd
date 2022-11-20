extends Spatial


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

onready var UnitMesh = $Charackter/MeshBody
onready var shader:ShaderMaterial
onready var navagent:NavigationAgent = $"NavigationAgent"
#onready var navigation:Spatial = get_node("/root/Main/Navigation")
onready var unitbase = get_node("%ObjectType")

export var is_selected:bool = false
export var _canselectbuilding : bool = true
onready var _ObjectTypeNode = get_node("%ObjectType")

var unitmanager


# Called when the node enters the scene tree for the first time.
func _ready():
	shader = UnitMesh.mesh.material.next_pass
	
	var unitmanager_id = unitbase.GM.get_manager_instance("UnitManager")
	
	if unitmanager_id > 0:
		unitmanger = instance_from_id(unitmanger_id)
		
	if is_instance_valid(unitmanager):
		unitmanger.register_unit_inManager(self)	# TODO: Registrer der Unit korrigieren
	else:
		print_debug("Charackter -> Unit Registration Failed!")


func _enter_tree():
	pass


func _input(_event):
	if Input.is_action_just_pressed("MouseClickLeftButton", true):
#		if is_selected:
		pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func can_selected() -> bool:
	return _canselectbuilding

func select_object(selected:bool) -> void:
	print_debug("UNit selected")
	is_selected = selected
	if is_selected:
		shader.set_shader_param("strenght", 0.5)
	else:
		shader.set_shader_param("strenght", 0.0)


func SetAgentTarget(newAgentTarget:Vector3)-> void:
	print_debug("SetAgentTarget: %s" % newAgentTarget)
	navagent.set_target_location(newAgentTarget)


func _on_NavigationAgent_velocity_computed(_safe_velocity):
	pass # Replace with function body.


func get_objecttype_node() -> Node:
	return _ObjectTypeNode


func get_objecttype():
	return _ObjectTypeNode._ObjectType


func _set_objecttype(_value):
	pass


