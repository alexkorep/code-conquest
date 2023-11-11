extends Sprite

var current_level = 0
var levels = []
var task_description

onready var progress_bar = get_parent().get_node("HealthProgressBar")

func _ready():
	task_description = $"../TaskDescription"
	progress_bar.value = 0
	levels = load_levels()
	update_display()

func _input(event):
	# Check if the event is a mouse button event, 
	# if it's pressed, and if the click is on the sprite.
	if (event is InputEventMouseButton 
		and event.pressed 
		and self.get_rect().has_point(to_local(event.position))):
		progress_bar.value += 10  # Increase by 10 each click, or your desired increment.
		if progress_bar.value >= 100:
			progress_bar.value = 0
			current_level += 1
			if current_level >= len(levels):
				current_level = 0
			update_display()

func update_display():
	var level = levels[current_level]
	self.texture = level.image
	task_description.text = level.text
	

func load_levels():
	var PATH = "res://assets/levels"
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
				if res is LevelStructure:
					resources_array.append(res)
			file_name = dir.get_next()
		dir.list_dir_end()
	else:
		print("An error occurred when trying to open the directory.")
	print(resources_array)
	return resources_array

