extends Node3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
@export var is_selected:bool = false
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


@onready var UnitMesh = $Charackter/MeshBody
@onready var shader:ShaderMaterial
@onready var navagent:NavigationAgent3D = $"NavigationAgent3D"
@onready var navigation:Node3D = get_node("/root/Main/Node3D")
@onready var unitbase = get_node("%ObjectType")


# Called when the node enters the scene tree for the first time.
func _ready():
	shader = UnitMesh.mesh.material.next_pass
	var UN = unitbase.GM.get_manager_instance("UnitManager")
	if UN != null: 
		UN.register_unit_inManager(self)	# TODO: Registrer der Unit korrigieren
	else:
		print_debug("Charackter -> Unit Registration Failed!")


func _enter_tree():
	pass


func _input(event):
	if Input.is_action_just_pressed("MouseClickLeftButton", true):
#		if is_selected:
		pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _select_unit(selected:bool) -> void:
	print_debug("UNit selected")
	is_selected = selected
	if is_selected:
		shader.set_shader_parameter("strenght", 0.5)
	else:
		shader.set_shader_parameter("strenght", 0.0)


func _SetAgentTarget(newAgentTarget:Vector3)-> void:
	print_debug("SetAgentTarget: %s" % newAgentTarget)
	navagent.set_target_location(newAgentTarget)


func _on_NavigationAgent_velocity_computed(_safe_velocity):
	pass # Replace with function body.
