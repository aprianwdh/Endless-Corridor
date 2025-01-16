extends Node2D


func play_pickup():
	$pickup_sound.play()
	
func play_paper_sound():
	$paper_pickup.play()
	
func play_walk():
	$walk.play()
	
func stop_walk():
	$walk.stop()

func play_run():
	$run.play()
	
func stop_run():
	$run.stop()
