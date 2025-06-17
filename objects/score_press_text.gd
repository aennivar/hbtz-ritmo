extends Control

# PERFECT f665ff
# GREAT 9354ff
# GOOD 76a1fe
# OK ffc775
# MISS 5a5758


func SetTextInfo(text: String):
	$ScoreLevelText.text = "[center]" + text
	
	match text:
		"PERFECT":
			$ScoreLevelText.set("theme_override_colors/default_color", Color("f665ff"))
		"GREAT":
			$ScoreLevelText.set("theme_override_colors/default_color", Color("9354ff"))
		"GOOD":
			$ScoreLevelText.set("theme_override_colors/default_color", Color("76a1fe"))
		"OK":
			$ScoreLevelText.set("theme_override_colors/default_color", Color("ffc775"))
		_:
			$ScoreLevelText.set("theme_override_colors/default_color", Color("5a5758"))
