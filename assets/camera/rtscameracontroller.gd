extends Spatial

########################
# SIGNALS
########################
# warning-ignore:unused_signal
signal freeze_requested
# warning-ignore:unused_signal
signal jump_requested(location, duration)
signal camera_moved(new_location)


########################
# EXPORT PARAMS
########################
# movement
export (float, 0, 100, 0.5) var movement_speed = 20.0
# zoom
export (float, 0, 100, 0.5) var min_zoom = 3.0
export (float, 0, 100, 0.5) var max_zoom = 20.0
export (float, 0, 100, 0.5) var zoom_speed = 20.0
export (float, 0, 1, 0.05) var zoom_speed_damp = 0.8
# rotation
export (int, 0, 90) var min_elevation_angle = 10
export (int, 0, 90) var max_elevation_angle = 80
export (float, 0, 100, 0.5) var rotation_speed = 20.0
# pan
export (float, 0, 10, 0.5) var pan_speed = 2.0
# flags
export var allow_wasd_movement: bool = true
export var allow_zoom: bool = true
export var zoom_to_curser: bool = true
export var allow_rotation: bool = true
export var inverted_y: bool = false
export var allow_pan: bool = true


########################
# PARAMS
########################
# movement
onready var tween = $Tween
var _lock_movement: bool = false
# zoom
onready var camera = $Elevation/Camera
var zoom_direction = 0
# rotation
onready var elevation = $Elevation
var is_rotating = false
# pan
var is_panning = false
# click position
const RAY_LENGTH = 1000
const GROUND_PLANE = Plane(Vector3.UP, 0)
var _last_mouse_position = Vector2()


########################
# OVERRIDE FUNCTIONS
########################
func _ready() -> void:
#	if !is_connected("GameStateChange", self, "_on_GameStateChange"):
#		if connect("GameStateChange", self, "_on_GameStateChange"):
#	camera_moved
#	if !is_connected("freeze_requested", self, "_freeze_camera"):
#		var conn = self.connect("freeze_requested", self, "_freeze_camera")
#		assert(conn, "Connect von Signal freeze_request gescheitert")
#	if !is_connected("jump_requested", self, "_jump_to_position"):
#		var conn = self.connect("jump_requested", self, "_jump_to_position")
#		assert(conn, "Connect von Signal jump_request gescheitert")
	pass



func _process(delta: float) -> void:
	if _lock_movement:
		return
	_move(delta)
	_rotate_and_elevate(delta)
	_zoom(delta)
	_pan(delta)


func _input(event: InputEvent) -> void:
	# zoom
	if event.is_action_pressed("camera_zoom_in"):
		zoom_direction = -1
	if event.is_action_pressed("camera_zoom_out"):
		zoom_direction = 1
	# rotation
	if event.is_action_pressed("camera_rotate"):
		is_rotating = true
		_last_mouse_position = get_viewport().get_mouse_position()
	if event.is_action_released("camera_rotate"):
		is_rotating = false
	# pan
	if event.is_action_pressed("camera_pan"):
		is_panning = true
		_last_mouse_position = get_viewport().get_mouse_position()
	if event.is_action_released("camera_pan"):
		is_panning = false
#	if Input.is_action_just_pressed("MouseClickLeftButton", true):
#		_select_object()


##############################
# MOVEMENT FUNCTIONS
##############################
#func _select_object() -> void:
#	var spaceSTate = get_world().direct_space_state
#	var mousePos = get_viewport().get_mouse_position()
#	var rayOrigin = camera.project_ray_origin(mousePos)
#	var rayEnd = rayOrigin + camera.project_ray_normal(mousePos) * 2000
##	var ray = PhysicsRayQueryParameters3D.create(rayOrigin, rayEnd)
##	var rayArray = spaceSTate.intersect_ray(ray)
#	var rayArray = spaceSTate.intersect_ray(rayOrigin, rayEnd)
#
#	if rayArray.has("collider"):
#		printt(rayArray)
#		var collider = rayArray["collider"]
#		if collider is KinematicBody:
##			var c = collider.get_children()
#			var NavAgent = collider.get_node("/root/Main/CharackterRoot/NavigationAgent")
#			if NavAgent != null:
#				if collider.get_parent_spatial().has_method("_select_unit") != false:
##					selectedUnit = collider
#					collider.get_parent_spatial()._select_unit(true)
#		elif collider.has_method("_select_unit"):
#			collider.select_unit(false)


func _move(delta: float) -> void:
	if not allow_wasd_movement:
		return
	var velocity = _get_desiered_velocity() * delta * movement_speed
	_translate_position(velocity)


func _rotate_and_elevate(delta: float) -> void:
	if not allow_rotation or not is_rotating:
		return
	var mouse_speed = _get_mouse_speed()
	_rotate(mouse_speed.x, delta)
	_elevate(mouse_speed.y, delta)


func _rotate(amount: float, delta: float) -> void:
	rotation_degrees.y += rotation_speed * amount * delta


func _elevate(amount: float, delta: float) -> void:
	var new_elevation = elevation.rotation_degrees.x
	if inverted_y:
		new_elevation += rotation_speed * amount * delta
	else:
		new_elevation -= rotation_speed * amount * delta
	elevation.rotation_degrees.x = clamp(
		new_elevation, -max_elevation_angle, -min_elevation_angle
		)


func _zoom(delta: float) -> void:
	if not allow_zoom or not zoom_direction:
		return
	var new_zoom = clamp(
		camera.translation.z + zoom_direction * zoom_speed * delta,
		min_zoom,
		max_zoom
	)
	var pointing_at = _get_ground_position()
	camera.translation.z = new_zoom
	# pan if need to zoom to curser
	if zoom_to_curser and pointing_at != null:
		_realign_camera(pointing_at)
	# faze out speed
	zoom_direction *= zoom_speed_damp
	if abs(zoom_direction) < 0.0001:
		zoom_direction = 0


func _pan(delta: float) -> void:
	if not allow_pan or not is_panning:
		return
	# get mouse speed
	var mouse_speed = _get_mouse_speed()
	# transform to velocity
	var velocity = (global_transform.basis.z * mouse_speed.y + global_transform.basis.x * mouse_speed.x) * delta * pan_speed
	# translate
	_translate_position(-velocity)


func _jump_to_position(locaiton: Vector3, duration: float) -> void:
	_lock_movement = true
	locaiton.y = 0
	tween.interpolate_property(
		self, "translation", translation, locaiton,
		duration, Tween.TRANS_SINE, Tween.EASE_OUT
	)
	tween.start()


##############################
# HELPERS
##############################
func _end_jump() -> void:
	_lock_movement = false


func _get_mouse_speed() -> Vector2:
	# calculate speed
	var current_mouse_pos = get_viewport().get_mouse_position()
	var mouse_speed = current_mouse_pos - _last_mouse_position
	# update last click position
	_last_mouse_position = current_mouse_pos
	# return speed
	return mouse_speed


func _realign_camera(point: Vector3) -> void:
	var new_position = _get_ground_position()
	if new_position == null:
		return
	_translate_position(point - new_position)


func _translate_position(v: Vector3) -> void:
	translation += v
	emit_signal("camera_moved", translation)


func _get_ground_position() -> Vector3:
	var mouse_pos = get_viewport().get_mouse_position()
	var ray_from = camera.project_ray_origin(mouse_pos)
	var ray_to = ray_from + camera.project_ray_normal(mouse_pos) * RAY_LENGTH
	return GROUND_PLANE.intersects_ray(ray_from, ray_to)


func _get_desiered_velocity() -> Vector3:
	var velocity = Vector3()
	# dont move if panning
	if is_panning:
		return velocity
	# get input
	if Input.is_action_pressed("camera_forward"):
		velocity -= transform.basis.z
	if Input.is_action_pressed("camera_backward"):
		velocity += transform.basis.z
	if Input.is_action_pressed("camera_left"):
		velocity -= transform.basis.x
	if Input.is_action_pressed("camera_right"):
		velocity += transform.basis.x
	return velocity.normalized()


func _freeze_camera() -> void:
	_lock_movement = true

































