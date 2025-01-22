extends SpotLight3D

@onready var texture_battery = $"../../UI_Manager/battery/texture_battery"
var battery_drain = 0.05

# Called when the node enters the scene tree for the first time.
func _ready():
	print("flashligh visible "+str(visible))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	texture_battery.visible = GlobalScript.have_senter
	if Input.is_action_just_pressed("senter") && GlobalScript.have_senter && texture_battery.value != 0:
		visible = !visible
		$toggle.play()
	if visible:
		texture_battery.value -= battery_drain * delta
	if texture_battery.value == 0 && visible == true:
		visible = false
		#texture_battery.visible = false
	if Input.is_action_just_pressed("senter") && GlobalScript.have_senter && texture_battery.value <= 0:
		$toggle_empty.play()
		await $toggle_empty.finished
		
		
