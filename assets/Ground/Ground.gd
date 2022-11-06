extends Spatial


export var _canselectbuilding : bool = false
onready var _ObjectTypeNode = get_node("%ObjectType")


func _ready():
	pass


func can_selected() -> bool:
	return _canselectbuilding


