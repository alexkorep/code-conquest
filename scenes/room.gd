extends Sprite

var current_level = 0
var levels := []
var task_description

onready var progress_bar = get_parent().get_node("HealthProgressBar")

func _ready():
	task_description = $"../TaskDescriptionRect/TaskDescription"
	levels = load_levels()
	update_display()
	reset_progress_bar()
	
func reset_progress_bar():
	progress_bar.value = 0
	progress_bar.max_value = get_current_level().health
	

func _input(event):
	# Check if the event is a mouse button event, 
	# if it's pressed, and if the click is on the sprite.
	if (event is InputEventMouseButton 
		and event.pressed 
		and self.get_rect().has_point(to_local(event.position))):
		# TODO calculate hitpoints
		progress_bar.value += 1  # Increase by 10 each click, or your desired increment.
		if progress_bar.value >= progress_bar.max_value:
			progress_bar.value = 0
			current_level += 1
			if current_level >= len(levels):
				current_level = 0
			reset_progress_bar()
			update_display()

func update_display():
	var level = levels[current_level]
	self.texture = level.image
	task_description.text = level.text
	

func load_levels():
	var PATH = "res://resources/levels"
	var resources_array = []
	var dir = Directory.new()
	# Open the directory
	if dir.open(PATH) == OK:
		# List all files in the directory
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if file_name.ends_with(".tres"):  # Check for .tres files
				# Load the resource and append it to the array
				var res = load(PATH + "/" + file_name)
				if res is Level:
					resources_array.append(res)
			file_name = dir.get_next()
		dir.list_dir_end()
	else:
		print("An error occurred when trying to open the directory.")
	return resources_array

func _on_Timer_timeout():
	print(progress_bar.value)
	if progress_bar.value > 0:
		var level = get_current_level()
		progress_bar.value -= level.health_restore_per_second
		if progress_bar.value < 0:
			progress_bar.value = 0

func get_current_level():
	return levels[current_level]
