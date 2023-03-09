extends CanvasLayer

var score = 0
func _on_main_score_up():
	score += 1
	$ScoreLabel.text = str(score)
