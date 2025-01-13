extends Node3D

@export var mouse_sensitivity: Vector2 = Vector2(0.002, 0.1)
@export var pitch_limit: float = 80.0
var mouse_mode : bool = false

var rotation_pitch: float = 0.0

func _process(delta):
	camera_player_movable()
	
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event: InputEvent):
	if GlobalScript.player_movable == true:
		if event is InputEventMouseMotion:
			# Rotasi horizontal (yaw)
			rotate_y(-event.relative.x * mouse_sensitivity.x)

			# Rotasi vertikal (pitch)
			rotation_pitch -= event.relative.y * mouse_sensitivity.y
			rotation_pitch = clamp(rotation_pitch, -pitch_limit, pitch_limit)

			# Terapkan rotasi pitch
			rotation.x = deg_to_rad(rotation_pitch)

func _input(_event: InputEvent):
	if Input.is_action_just_pressed("ui_cancel"):
		mouse_mode = !mouse_mode
		if mouse_mode == true:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		elif mouse_mode == false:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func camera_player_movable():
	if GlobalScript.player_movable == true:
		$Camera3D.current = true
	else :
		$Camera3D.current = false
