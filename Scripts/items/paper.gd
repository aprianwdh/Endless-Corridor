extends StaticBody3D

signal paper_oon
signal paper_off
@export var material_paper : StandardMaterial3D
@export var texture_ui_paper : Texture2D
var toggle = false
var node_texture_paper
# Called when the node enters the scene tree for the first time.
func _ready():
	$MeshInstance3D.material_override = material_paper
	node_texture_paper = get_node("/root/"+get_tree().current_scene.name+"/player/UI_Manager/TexturePaper")



func interact():
	AudioManager.play_paper_sound()
	node_texture_paper.texture = texture_ui_paper
	toggle = !toggle
	GlobalScript.player_movable = !toggle
	#GlobalScript.paper_on = toggle
	if toggle == true:
		emit_signal("paper_oon")
	elif toggle == false:
		emit_signal("paper_off")
	
	#UiManager.change_texture_paper(texture_ui_paper)
