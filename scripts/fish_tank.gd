extends Node2D
const FISH = preload("res://scenes/fish.tscn")
@onready var panel: Panel = $Panel
@onready var label: Label = $Label
signal update_label_signal
signal murder_fish

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(10):
		spawn_random_fish()

func spawn_fish(primary,secondary,template,size,pos,facing):
	var newFish = FISH.instantiate()
	newFish.primary_color = primary
	newFish.secondary_color = secondary
	newFish.temp = template
	newFish.scale = size
	
	var half_width = 955 * 0.5 * newFish.scale.x
	var xbound1 = panel.position.x + half_width
	var xbound2 = panel.position.x + panel.size.x - half_width
	var ybound1 = panel.position.y + half_width
	var ybound2 = panel.position.y + panel.size.y - half_width
	
	newFish.position = pos
	newFish.bounds = Vector4(xbound1,ybound1,xbound2,ybound2)
	
	newFish.facing_dir = facing
	
	newFish.connect("earn_money", earn_money)
	$Fish.call_deferred("add_child",newFish)
	
func spawn_random_fish():
	var newFish = FISH.instantiate()
	newFish.primary_color = Color(randf(),randf(),randf())
	newFish.secondary_color = Color(randf(),randf(),randf())
	newFish.temp = randi_range(0,len(newFish.templates) - 1)
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
	$Fish.call_deferred("add_child",newFish)

func earn_money(amount):
	update_label_signal.emit(amount)
	
	

func food_eaten(area,type):
	for fish in $Fish.get_children():
		if fish.get_node('Area') == area:
			if type == 3:
				fish.murder_fish()
				murder_fish.emit()
				return
				
			var tween = create_tween()
			tween.set_ease(Tween.EASE_IN_OUT)
			tween.tween_property(fish,'scale',fish.scale + Vector2(0.02,0.02) * type, 0.1)
			
			if fish.scale.x > 0.05:
				tween.kill()
				tween = create_tween()
				tween.set_ease(Tween.EASE_IN_OUT)
				tween.tween_property(fish,'scale',fish.scale - Vector2(0.01,0.01), 0.1)
				var num = 1
				if type == 2:
					num = randi_range(3,8)
				for i in range(num):
					var primary = fish.primary_color if randf() > 0.1 else Color(randf(),randf(),randf())
					var secondary = fish.secondary_color if randf() > 0.1 else Color(randf(),randf(),randf())
					var temp = fish.temp if randf() > 0.1 else randi_range(0,len(fish.templates) - 1)
					var randsize = randf_range(0.01,0.03)
					spawn_fish(primary, secondary, temp ,Vector2(randsize,randsize),fish.position + Vector2(0,30),fish.facing_dir)
			return
	print('no fish with area found, likely interacted with another pellet')
