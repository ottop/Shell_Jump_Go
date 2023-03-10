extends CanvasLayer

signal restart
signal pause
signal resume

@export var score_increment = 1

var score = 0

func _on_main_score_up():
	score += score_increment
	$ScoreLabel.text = str(score)


func _on_restart_pressed():
	score = 0
	$ScoreLabel.text = str(score)
	$Gameover.hide()
	$Restart.hide()
	$Quit.hide()
	restart.emit()


func _on_quit_pressed():
	get_tree().quit()


func _on_pause_pressed():
	pause.emit()


func _on_continue_pressed():
	resume.emit()
