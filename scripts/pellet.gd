extends Node2D
var type : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if type == 2:
		modulate = Color.RED
	if type == 3:
		modulate = Color.GREEN


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position = get_global_mouse_position()
