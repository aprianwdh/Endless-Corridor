extends Control

var mouse_mode : bool = false

func _ready():
	visible = false

func _process(_delta):
	if get_tree().paused == true:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		visible = true
	else :
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		visible = false

func _input(event):
	if event.is_action_pressed("paused"):
		get_tree().paused = !get_tree().paused
		#visible = get_tree().paused
		#mouse_mode = !mouse_mode
		#if mouse_mode == true:
			#Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		#elif mouse_mode == false:
			#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _on_resume_pressed():
	get_tree().paused = !get_tree().paused
	#visible = false
	#mouse_mode = !mouse_mode
	#if mouse_mode == true:
		#Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	#elif mouse_mode == false:
		#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _on_main_manu_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Sceens/UI/main_menu.tscn")


func _on_quit_pressed():
	get_tree().quit()
