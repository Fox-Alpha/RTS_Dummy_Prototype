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
		#"Building_[ID]": {
			# "queue": []	# Array mit ObjectTypeID's
			# "is_building": false
			# "buildingid": -1
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
func _ready():
	#newobject_tobuildqueue_added
	if !Signalbus.is_connected("newobject_tobuildqueue_added", self, "_on_newobject_tobuildqueue_added"):
		var _sig = Signalbus.connect("newobject_tobuildqueue_added", self, "_on_newobject_tobuildqueue_added")

	if !Signalbus.is_connected("newobject_build_has_endeded", self, "_on_newobject_buildqueue_buildended"):
		var _sig = Signalbus.connect("newobject_build_has_endeded", self, "_on_newobject_buildqueue_buildended")

#func _init():
#	pass


# func _enter_tree():
#	pass


# func _exit_tree():
#	pass


# func _process(_delta):
# 	pass


func _physics_process(_delta):
	for bq in BuildingQueueList.values():
		if bq.size() > 0:
			if !bq["is_building"] and bq["queue"].size() > 0:
				var nextType = bq["queue"].pop_front()
				Signalbus.emit_signal("newobject_build_has_started", nextType,  bq["buildingid"])
				bq["is_building"] = true
			# print(queue, " / ", bq.name)
			# newobject_build_has_started

# ===========================

func add_building_to_manager(building_id:int):
	BuildingQueueList["building_" + str(building_id)] = {
		"queue": [],
		"buildingid": building_id,
		"is_building": false
	}


func _on_newobject_tobuildqueue_added(newtype, Building_ID):
	if BuildingQueueList.has("building_" + str(Building_ID)):
		BuildingQueueList["building_" + str(Building_ID)]["queue"].append(newtype)


func _on_newobject_buildqueue_buildended(newtype, Building_ID):
	if BuildingQueueList.has("building_" + str(Building_ID)):
		BuildingQueueList["building_" + str(Building_ID)]["is_building"] = false

	
