extends Control

var score: int = 0
var combo_count: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	Signals.IncrementScore.connect(IncrementScore)
	Signals.IncrementCombo.connect(IncrementCombo)
	Signals.ResetCombo.connect(ResetCombo)

func IncrementScore(incr: int):
	score += incr
	%ScoreLabel.text = str(score) + " pts"

func IncrementCombo():
	combo_count += 1

func ResetCombo():
	combo_count = 0
