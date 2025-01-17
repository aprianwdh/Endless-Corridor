extends Area3D

@export var animation : AnimationPlayer
@export var anim_name : String
@export var sound_trigger : AudioStreamPlayer


func _on_body_entered(body):
	if body.is_in_group("Player"):
		if sound_trigger != null:
			sound_trigger.play()
		else:
			print("sound not found")
		animation.play(anim_name)
		await animation.animation_finished
		queue_free()
