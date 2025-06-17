extends Sprite2D

@export var key_name: String = ""

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed(key_name):
		print(key_name)
