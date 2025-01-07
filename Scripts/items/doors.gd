extends Node3D

@onready var animasi =  $"../../AnimationPlayer"


var interactable = true
var oppened = false

func interact():
	if interactable == true:
		interactable = false
		oppened = !oppened
		
		if oppened == false:
			animasi.play("door_closed")
		if oppened == true:
			animasi.play("door_open")
			
		await get_tree().create_timer(1.0,false).timeout
		interactable = true
