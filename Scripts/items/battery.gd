extends StaticBody3D

var node_flashlight

func interact():
	if GlobalScript.have_senter:
		AudioManager.play_pickup()
		node_flashlight = get_node("/root/"+get_tree().current_scene.name+"/player/UI_Manager/battery/texture_battery")
		node_flashlight.value = min(GlobalScript.energy_flashlight + 0.5 , 1)
		queue_free()
