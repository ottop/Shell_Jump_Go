extends CanvasLayer

signal restart
signal pause
signal resume

@export var score_increment = 1

var score = 0

# This function is for Android. Android score label font size is 46, desktop is 42
func _ready():
	$Scoreblock.scale = Vector2(0.8,0.8)
	$ScoreLabel.scale = Vector2(1.1,1.1)
	$Pause.scale = Vector2(0.3,0.3)
	$Pause.position.x = 60
	$Pause.position.y = 10
	$Restart.scale = Vector2(0.7,0.7)
	$Restart.position.x = $Restart.position.x/ (0.7/0.5)
	$Restart.position.y -= 20
	$Quit.scale = Vector2(0.7,0.7)
	$Quit.position.x = $Quit.position.x / (0.7/0.5)
	$Continue.scale = Vector2(0.7,0.7)
	$Continue.position.x = $Continue.position.x / (0.7/0.5)
	$Continue.position.y -= 20

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
