extends CharacterBody3D

@export var nav: NavigationAgent3D
@export var targets: CharacterBody3D
@export var SPEED: float = 2.0
@export var GRAVITY: float = 9.8
@export var INTERPOLATION_SPEED: float = 0.25

func _process(delta):
	if targets:  # Pastikan target valid
		target_position(targets)
	
	# Hitung gravitasi
	if not is_on_floor():
		velocity.y -= GRAVITY * delta
	#else:
		#velocity.y = 0  # Reset gravitasi saat di lantai
	
	# Periksa navigasi dan gerakkan karakter
	if not nav.is_navigation_finished():
		var next_location = nav.get_next_path_position()
		var current_location = global_transform.origin
		var new_velocity = (next_location - current_location).normalized() * SPEED

		# Interpolasi menuju kecepatan baru
		velocity = velocity.move_toward(new_velocity, INTERPOLATION_SPEED)

	move_and_slide()

func target_position(target: CharacterBody3D):
	# Tetapkan posisi target navigasi
	nav.target_position = target.global_transform.origin
