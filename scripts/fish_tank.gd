extends Node2D
const FISH = preload("res://scenes/fish.tscn")
@onready var panel: Panel = $Panel
@onready var label: Label = $Label
var money = 999
signal update_label_signal

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(3):
		spawn_random_fish()
	update_label()

func spawn_random_fish():
	var newFish = FISH.instantiate()
	newFish.primary_color = Color(randf(),randf(),randf())
	newFish.secondary_color = Color(randf(),randf(),randf())
	newFish.temp = randi_range(0,3)
	var randscale = randf_range(0.01,0.05)
	newFish.scale = Vector2(randscale, randscale)
	
	var half_width = 955 * 0.5 * newFish.scale.x
	var xbound1 = panel.position.x + half_width
	var xbound2 = panel.position.x + panel.size.x - half_width
	var ybound1 = panel.position.y + half_width
	var ybound2 = panel.position.y + panel.size.y - half_width
	
	var randpos = Vector2( \
						randf_range(xbound1 + 100, xbound2 - 100), \
						randf_range(ybound1 + 100, ybound2 - 100)  \
						)
	
	newFish.position = randpos
	newFish.bounds = Vector4(xbound1,ybound1,xbound2,ybound2)
	
	newFish.facing_dir = randi_range(-180,180)
	
	newFish.connect("earn_money", earn_money)
	add_child(newFish)

func earn_money(amount):
	money += amount
	update_label()
	

func update_label():
	update_label_signal.emit(money)

func button_pressed(id):
	if id == 1:
		money -= 10
		update_label()
		spawn_random_fish()
