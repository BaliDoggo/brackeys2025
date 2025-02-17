extends Node2D
const FISH = preload("res://scenes/fish.tscn")
@onready var panel: Panel = $Panel
@onready var label: Label = $Label
var money = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(3):
		spawn_random_fish()
	update_label()

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
	
	newFish.connect("earn_money", earn_money)
	add_child(newFish)

func earn_money(amount):
	money += amount
	update_label()
	

func update_label():
	label.text = "$ " + str(money)
	
func _on_fish_1_pressed() -> void:
	if money >= 10:
		money -= 10
		update_label()
		spawn_random_fish()
