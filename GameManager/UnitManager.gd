class_name UnitManager
extends Node

export(Array) var Units = []


func _init():
	print("UnitManager::_init() -> Created")
#	pass


#func _ready():
#	pass


#func _enter_tree():
#	pass


#func _exit_tree():
#	pass


func register_unit_inManager(unit) -> bool:
	if !Units.has(unit):
		Units.append([unit])
	# Sicherstellen das es sich um den Klassentypen Unit handelt
	print_debug("Neue Unit hat sich Registriert %s: " % unit.unitbase.get_unit_name())
	return true
