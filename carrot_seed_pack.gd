extends StaticBody2D

var selected = false
var seed_type = 1  # Carrot (you can change this to 2 for Onion, etc.)

func _ready() -> void:
	# Play the default animation when the object is ready
	$AnimatedSprite2D.play("default")

# This function handles mouse click events
func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			# If the mouse is pressed, select the plant and set the global selected plant type
			Global.plantselected = seed_type
			selected = true
			print("Plant selected:", seed_type)  # Debugging: shows which plant is selected
		else:
			# If the mouse is released, deselect the plant
			selected = false
			print("Plant deselected.")  # Debugging: shows when the plant is deselected

# This function moves the selected plant to the mouse position
func _physics_process(delta: float) -> void:
	if selected:
		# Lerp smoothly to the global mouse position
		global_position = lerp(global_position, get_global_mouse_position(), 25 * delta)

# Optional: If you want to use the _input() method to check for input events globally
func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
		# In case you want to do something when mouse is released globally, use this
		selected = false
