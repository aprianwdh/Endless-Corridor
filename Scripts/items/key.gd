extends StaticBody3D


func interact():
	$AudioStreamPlayer.play()
	hide()
	GlobalScript.jumlah_key += 1
	await get_tree().create_timer(0.95).timeout
	queue_free()
