extends StaticBody3D

@export var texture_paint : StandardMaterial3D
# Called when the node enters the scene tree for the first time.
func _ready():
	$texture_paint.material_override = texture_paint


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
