class_name BuildingManager
extends ManagerBase

# ===========================
# Dieser Manager ist dafür verantwortlich das Aktionen an und von einem 
# Gebäude weitergeleitet werden.
# 
# Bauen von Gebäuden
# Behandeln der notwendigen Resourcen
# ===========================

export var Buildings : Dictionary = {}

# ===========================
# Build-in Methoden
# ===========================
func _ready():
	# Ein neues Object instantiieren
	if not Signalbus.is_connected("instantiatenewobject", self, "_on_instantiate_new_object"):
		var _sig = Signalbus.connect("instantiatenewobject", self, "_on_instantiate_new_object")
#		assert(sig == OK, "ObjectManager::init_signals() -> connect objunectselected failed")
	pass


#func _init():
#	pass


# func _enter_tree():
#	pass


# func _exit_tree():
#	pass
# ===========================
