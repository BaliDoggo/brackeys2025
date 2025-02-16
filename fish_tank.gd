extends Node2D
const FISH = preload("res://scenes/fish.tscn")
@onready var panel: Panel = $Panel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(3):
		spawn_random_fish()

func spawn_random_fish():
	var newFish = FISH.instantiate()
	newFish.primary_color = Color(randf(),randf(),randf())
	newFish.secondary_color = Color(randf(),randf(),randf())
	var randscale = randf_range(0.5,0.7)
	newFish.scale = Vector2(randscale, randscale)
	
	var xbound1 = panel.position.x
	var xbound2 = panel.position.x + panel.size.x
	var ybound1 = panel.position.y
	var ybound2 = panel.position.y + panel.size.y
	
	var randpos = Vector2( \
						randf_range(xbound1, xbound2), \
						randf_range(ybound1, ybound2)  \
						)
	
	newFish.position = randpos
	newFish.bounds = Vector4(xbound1,ybound1,xbound2,ybound2)
	
	newFish.facing_dir = randi_range(-180,180)
	add_child(newFish)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
