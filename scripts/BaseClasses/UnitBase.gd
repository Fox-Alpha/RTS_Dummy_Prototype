class_name UnitBase
extends Node


export var UnitName : String = "EmptyUnitName" setget set_unit_name,get_unit_name
export var UnitType : String = "EmptyUnitType" setget set_unit_type,get_unit_type

export var _canselectunit : bool = true

onready var GM = get_tree().get_root().get_node("Main/GameManager")
onready var UnitRootNode = owner


func _ready():
	pass


func _enter_tree():
	pass


func _exit_tree():
	pass


func can_selected() -> bool:
	return _canselectunit


func set_unit_name(value:String) -> void:
	if value != UnitName and not value.empty():
		UnitName = value


func get_unit_name() -> String:
	return UnitName


func set_unit_type(value:String) -> void:
	if value != UnitType and not value.empty():
		UnitType = value


func get_unit_type() -> String:
	return UnitType
