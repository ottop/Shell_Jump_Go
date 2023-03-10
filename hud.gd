extends CanvasLayer

signal restart

var score = 0
func _on_main_score_up():
	score += 1
	$ScoreLabel.text = str(score)


func _on_restart_pressed():
	score = 0
	$ScoreLabel.text = str(score)
	restart.emit()


func _on_quit_pressed():
	get_tree().quit()
