extends Spatial


export var _canselectbuilding : bool = true

onready var _ObjectTypeNode = get_node("%ObjectType")
onready var BuildingMesh = $BaracksBody/MeshBuilding

onready var shader:ShaderMaterial = BuildingMesh.mesh.material.next_pass

export var is_selected:bool = false 


func select_object(selected:bool) -> void:
	print_debug("BuildingRoot::select_object() -> Building selected: %s" % selected)
	is_selected = selected
	if is_selected:
		shader.set_shader_param("strenght", 1.0)
	else:
		shader.set_shader_param("strenght", 0.0)


func can_selected() -> bool:
	return _canselectbuilding


func get_objecttype_node() -> Node:
	return _ObjectTypeNode


func get_objecttype():
	return _ObjectTypeNode._ObjectType


# Called when the node enters the scene tree for the first time.
# func _ready():
# 	shader = BuildingMesh.mesh.material.next_pass
#	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
