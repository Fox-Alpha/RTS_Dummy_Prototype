extends Node

# ===========================
# GameManager
# ===========================

# TODO: Rename -> 
# signal gamemanager_instantiated(GMInstance)
# warning-ignore:unused_signal
signal setgamemanagerinstance(GMInstance)

# TODO: Rename -> (GameManager::_ready())
# warning-ignore:unused_signal
signal game_manager_is_ready

# ===========================
# ObjectManager
# ===========================
# TODO: Registrieren aller selektierbaren Objecte
# warning-ignore:unused_signal
signal objectselected(Object_ID)

# TODO: Registrieren aller selektierbaren Objecte
# warning-ignore:unused_signal
signal objectunselected(Object_ID)

# warning-ignore:unused_signal
signal objectleftclicked(Object_ID)

# warning-ignore:unused_signal
signal objectrightclicked(Object_ID, clicked_position)

# ===========================
# Buildqueue
# ===========================
# TODO: Rename -> 
# signal buildqueue_newobject_added(newtype, Building_ID)
# warning-ignore:unused_signal
signal add_newobject_tobuildqueue(newtype, Building_ID)

# TODO: Rename -> 
# signal buildqueue_nextbuild_started(Building_ID)
# warning-ignore:unused_signal
signal newobject_build_has_started(Building_ID)

# TODO: Rename ?? -> 
# signal buildqueue_newobject_instantiated(newtype, Building_ID)
# warning-ignore:unused_signal
signal newobject_instantiated(newtype, Building_ID)


# ===========================
# Helper
# ===========================
# warning-ignore:unused_signal
signal scene_end_reached
