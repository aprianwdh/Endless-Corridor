extends CharacterBody3D


var SPEED = 5.0
var sprint_speed = 10.0
var original_speed
const JUMP_VELOCITY = 4.5
var sprint_slider
var sprint_drain_amount = 0.5
var sprint_recharge_amount = 0.2
@onready var senter = $head/senter


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	senter.hide()
	sprint_slider = $UI_Manager/Sprint_slider
	sprint_slider.hide()
	original_speed = SPEED
	



func _physics_process(delta):

	move_player(delta)
	move_and_slide()
	sprint(delta)
	
func move_player(delta):

	if GlobalScript.player_movable == true:
		# Add the gravity.
		if not is_on_floor():
			velocity.y -= gravity * delta

		# Handle jump.
		if Input.is_action_just_pressed("lompat") and is_on_floor():
			velocity.y = JUMP_VELOCITY

		# Get the input direction and handle the movement.
		var input_dir = Input.get_vector("gerak_kiri","gerak_kanan","gerak_bawah","gerak_atas")

		# Gunakan basis kamera untuk menentukan arah pergerakan.
		var camera = get_node("head/Camera3D") # Pastikan path ke kamera benar
		var camera_basis = camera.global_transform.basis

		# Ambil arah X dan Z dari kamera untuk pergerakan horizontal.
		var forward = -camera_basis.z.normalized()
		var right = camera_basis.x.normalized()

		# Hitung arah akhir berdasarkan input dan orientasi kamera.
		var direction = (forward * input_dir.y + right * input_dir.x).normalized()

		if direction:
			velocity.x = direction.x * SPEED
			velocity.z = direction.z * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.z = move_toward(velocity.z, 0, SPEED)

func sprint(delta):
	if GlobalScript.player_movable == true:
	#mengatur energi sprint
		if SPEED == sprint_speed:
			sprint_slider.value -= sprint_drain_amount * delta
			if sprint_slider.value == sprint_slider.min_value:
				SPEED = original_speed
		if SPEED != sprint_speed:
			if sprint_slider.value < sprint_slider.max_value:
				sprint_slider.value += sprint_recharge_amount * delta
			if sprint_slider.value == sprint_slider.max_value:
				sprint_slider.hide()
			
	#input button sprint
		if Input.is_action_just_pressed("sprint"):
			SPEED = sprint_speed
			sprint_slider.show()
		if Input.is_action_just_released("sprint"):
			SPEED = original_speed
