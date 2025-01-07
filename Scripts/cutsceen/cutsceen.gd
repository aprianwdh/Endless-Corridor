extends AnimationPlayer

@onready var camera = $Camera3D


func _process(delta):
	camera_player_movable()
func _ready():

	play("beggining")

func _on_animation_finished(anim_name):
	if anim_name == "beginning":
		pass

func movable():
	GlobalScript.player_movable = true
	
func no_movable():
	GlobalScript.player_movable = false
	
func camera_player_movable():
	if GlobalScript.player_movable :
		camera.current = false
	else :
		camera.current = true
