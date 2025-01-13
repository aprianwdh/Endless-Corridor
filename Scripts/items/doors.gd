extends Node3D

@onready var animasi =  $"../../AnimationPlayer"

@export var key_required : bool = true
var interactable = true
var oppened = false

func interact():
	if GlobalScript.jumlah_key > 0:
		key_required = false
		GlobalScript.jumlah_key -= 1
		if interactable == true and key_required == false:
			interactable = false
			oppened = !oppened
			
			if oppened == false:
				animasi.play("door_closed")
			if oppened == true:
				animasi.play("door_open")
				
			await get_tree().create_timer(1.0,false).timeout
			interactable = true
	elif GlobalScript.jumlah_key <= 0:
		if interactable == true and key_required == true:
			animasi.play("locked")
			await get_tree().create_timer(0.8,false).timeout
			interactable = true
