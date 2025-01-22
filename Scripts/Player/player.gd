extends CharacterBody3D


var SPEED = 5.0
var sprint_speed = 10.0
var original_speed
const JUMP_VELOCITY = 4.5
var sprint_slider
var sprint_drain_amount = 0.5
var sprint_recharge_amount = 0.2
@onready var senter = $head/senter
@onready var texture_paper = $UI_Manager/TexturePaper

var is_walking_sound_playing = false  # Melacak status suara langkah kaki
var is_running_sound_playing = false  # Melacak status suara sprint



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
	#Audio_walk_and_sprint()
	
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
	var input_dir = Input.get_vector("gerak_kiri","gerak_kanan","gerak_bawah","gerak_atas")
	if GlobalScript.player_movable == true :
		# Mengatur energi sprint
		if SPEED == sprint_speed && input_dir:
			sprint_slider.value -= sprint_drain_amount * delta
			if sprint_slider.value == sprint_slider.min_value:
				SPEED = original_speed
		if SPEED != sprint_speed:
			if sprint_slider.value < sprint_slider.max_value:
				sprint_slider.value += sprint_recharge_amount * delta
			if sprint_slider.value == sprint_slider.max_value:
				sprint_slider.hide()
		
		# Handle sprint input
		if Input.is_action_just_pressed("sprint") && input_dir:
			SPEED = sprint_speed
			sprint_slider.show()
			if not is_running_sound_playing:
				AudioManager.play_run()
				is_running_sound_playing = true
			if is_walking_sound_playing:
				AudioManager.stop_walk()
				is_walking_sound_playing = false
		elif Input.is_action_just_released("sprint"):
			SPEED = original_speed
			if is_running_sound_playing:
				AudioManager.stop_run()
				is_running_sound_playing = false
		
		# Handle movement input
		var movement_keys = ["gerak_atas", "gerak_bawah", "gerak_kanan", "gerak_kiri"]
		var is_moving = false
		for key in movement_keys:
			if Input.is_action_pressed(key):
				is_moving = true
				break

		if is_moving:
			if not is_walking_sound_playing and SPEED != sprint_speed:
				AudioManager.play_walk()
				is_walking_sound_playing = true
		else:
			if is_walking_sound_playing:
				AudioManager.stop_walk()
				is_walking_sound_playing = false


func _on_paper_paper_oon():
	texture_paper.show()


func _on_paper_paper_off():
	texture_paper.hide()
	#
#func _input(event):
	#if event.is_action_pressed("gerak_atas"):
		#AudioManager.play_walk()
	#elif event.is_action_pressed("gerak_bawah"):
		#AudioManager.play_walk()
	#elif event.is_action_pressed("gerak_kanan"):
		#AudioManager.play_walk()
	#elif event.is_action_pressed("gerak_kiri"):
		#AudioManager.play_walk()
	#else :
		#AudioManager.stop_walk()
