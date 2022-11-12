class_name BuildingManager
extends Node

# ===========================
# Dieser Manager ist dafür verantwortlich das Aktionen an und von einem 
# Gebäude weitergeleitet werden.
# 
# Bauen von Gebäuden
# Behandeln der notwendigen Resourcen
# 
# 
# 
# 
# 
# ===========================
var GM:Node

export(Array) var Buildings = []

func _ready():
	pass

func _init():
	print("BuildingManager::_init() -> Created")
#	pass


# func _enter_tree():
#	pass


# func _exit_tree():
#	pass


func SetGameManagerInstance():
	GM = Globals.get_gamemanager_instance()
