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

#Changed
export var BuildingQueueList : Dictionary = {
		"Building_[ID]": []	# Array mit ObjectTypeID's
	}



# TODO: Buildings müssen sich im Manager "Anmelden"
# TRYME: Per SIGNAL ?? Parameter: ObjectID, hasQueue TRUE|FALSE
# ADDME: Bei Anmeldung, BUILDING in Queueliste aufnehmen, wenn ObjectCanSpawnObjects == TRUE
# REFACTOR: Buildingqueue über Manager steuern
# ADDME: Abarbeiten der Queue's
# ADDME: Instanziieren neuer Objecte
# ADDME: Neue Objecte an BUILDING melden
# var id = get_instance_id()
# var inst = instance_from_id(id)


# ===========================
# Build-in Methoden
# ===========================
#func _ready():
#	pass


#func _init():
#	pass


# func _enter_tree():
#	pass


# func _exit_tree():
#	pass


# func _process(_delta):
# 	pass
# ===========================
