extends Control

@export var sceen_tujuan : PackedScene

func _ready():
	print(get_tree().paused)

func _on_play_pressed():
	get_tree().change_scene_to_packed(sceen_tujuan)


func _on_quit_pressed():
	get_tree().quit()
