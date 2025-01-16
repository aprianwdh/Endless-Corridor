extends Area3D

@export var animation : AnimationPlayer
@export var anim_name : String



func _on_body_entered(body):
	if body.is_in_group("Player"):
		animation.play(anim_name)
		await animation.animation_finished
		queue_free()
