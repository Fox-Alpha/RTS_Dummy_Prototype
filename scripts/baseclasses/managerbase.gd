extends Node
class_name ManagerBase

# ===========================
# Base Klasse von der alle Managerklassen abgeleitet werden
#
# Nur gemeinsame Eigenschaften und Methoden
# ===========================
var GM:Node

# ===========================
# Build-In Methoden
# ===========================
#func _init():
#	print("ManagerBase _init")
#	print("Instanz::_init() -> ", name)
##	pass
#
#
func _ready():
#	print("ManagerBase _ready()")
	print("Instanz::_ready() -> ", name)
#	pass


#func _enter_tree():
#	pass
#
#
#func _exit_tree():
#	pass
# ===========================

###################
func SetGameManagerInstance():
	GM = Globals.get_gamemanager_instance()
	print(name, "::SetGameManagerInstance() -> ", name)
###################
