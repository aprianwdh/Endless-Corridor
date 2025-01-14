extends Control

@onready var texture_paper = $TexturePaper


func _process(delta):
	if GlobalScript.paper_on == true:
		texture_paper.show()
	else :
		$TexturePaper.hide()
		
