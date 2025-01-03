extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _physics_process(delta):

	move_player(delta)
	move_and_slide()
	
func move_player(delta):
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

