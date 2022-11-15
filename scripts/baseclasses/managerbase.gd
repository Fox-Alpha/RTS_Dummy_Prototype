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
	if !Signalbus.is_connected("game_manager_is_ready", self, "on_game_manager_is_ready"):
		var _sig = Signalbus.connect("game_manager_is_ready", self, "on_game_manager_is_ready")
#	pass


#func _enter_tree():
#	pass
#
#
#func _exit_tree():
#	pass
# ===========================

func on_game_manager_is_ready():
	GM = Globals.get_gamemanager_instance()
	if is_instance_valid(GM):
		print(name, "::on_game_manager_is_ready() -> ", name)

###################
func SetGameManagerInstance():
	GM = Globals.get_gamemanager_instance()
	print(name, "::SetGameManagerInstance() -> ", name)
###################
