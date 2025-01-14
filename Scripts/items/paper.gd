extends StaticBody3D

signal paper_oon
signal paper_off
@export var material_paper : StandardMaterial3D
@export var texture_ui_paper : Texture2D
var toggle = false
# Called when the node enters the scene tree for the first time.
func _ready():
	$MeshInstance3D.material_override = material_paper



func interact():
	toggle = !toggle
	GlobalScript.player_movable = !toggle
	#GlobalScript.paper_on = toggle
	if toggle == true:
		emit_signal("paper_oon")
	elif toggle == false:
		emit_signal("paper_off")
	#get_node("/root/"+get_tree().current_scene.name+"/player/UI_Manager/TexturePaper").Texture = texture_ui_paper
	#UiManager.change_texture_paper(texture_ui_paper)
