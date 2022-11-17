#class_name Template_Script

#-------------------------------------------------------------------------------
# Header
#-------------------------------------------------------------------------------
#tool
#class_name
extends Node
# Registriert die Units Node im UnitManager
# TODO: Auf GameManager is Ready reagieren
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# Signals
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# enums
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# constants
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# exported variables
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# private variables
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# onready variables
#-------------------------------------------------------------------------------
#onready var myVar: string
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# optional built-in virtual methods
#-------------------------------------------------------------------------------
func _init() -> void:
	print("UnitsNode::_init() -> ", name)
	pass


func _ready() -> void:
	Signalbus.emit_signal("game_manager_is_ready")
	print("UnitsNode::_ready() -> ", name)
	pass


func _enter_tree():
	print("UnitsNode::_enter_tree() -> ", name)
	pass


func _exit_tree():
	print("UnitsNode::_exit_tree() -> ", name)
	pass
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# public methods Upper_Pascal_Case
#-------------------------------------------------------------------------------
#func Example_Method_Name(_exampleparam) -> void:
#	pass
#-------------------------------------------------------------------------------
# private methods, _lower_case
#-------------------------------------------------------------------------------

