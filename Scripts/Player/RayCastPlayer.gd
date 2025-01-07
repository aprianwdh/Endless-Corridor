extends RayCast3D

@onready var interact_label = $"../../UI_Manager/interact_label"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_colliding():
		var hit = get_collider()
		if hit.has_method("interact"):
			interact_label.show()
			if Input.is_action_just_pressed("interact"):
				hit.interact()
		else :
			interact_label.hide()
	else :
		interact_label.hide()
		
