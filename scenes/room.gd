extends Sprite

onready var progress_bar = get_parent().get_node("HealthProgressBar")

func _ready():
	progress_bar.value = 0

func _input(event):
	# Check if the event is a mouse button event, 
	# if it's pressed, and if the click is on the sprite.
	if (event is InputEventMouseButton 
		and event.pressed 
		and self.get_rect().has_point(to_local(event.position))):
		progress_bar.value += 10  # Increase by 10 each click, or your desired increment.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
