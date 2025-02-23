extends Node2D
var fish_tank = preload("res://scenes/fish_tank.tscn").instantiate()
var phone = preload("res://scenes/phone.tscn").instantiate()
var food = preload("res://scenes/food.tscn").instantiate()
var credits_scene = preload("res://scenes/credits.tscn").instantiate()
var murder

var strength = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_child(Label.new())
	fish_tank.connect("update_label_signal", phone.update_label)
	fish_tank.connect("murder_fish", murder_fish)
	phone.connect("button_pressed",food.food_purchased)
	food.connect("food_eaten_signal",fish_tank.food_eaten)
	add_child(fish_tank)
	add_child(phone)
	add_child(food)
	$Piano.play()
	$Ambiance.play()

func murder_fish():
	murder = true
	$Piano.stop()
	$Ambiance.stop()
	food.queue_free()
	phone.begin_panic()
	$Metal.play()

func jumpscare(pos):
	$Jumpscare.play()
	var scary = Sprite2D.new()
	scary.texture = preload("res://assets/image-removebg-preview (2).png")
	scary.position = pos
	scary.scale = Vector2(0.5,0.5)
	scary.z_index = 10
	var tween = create_tween()
	tween.tween_property(scary,"scale",Vector2(10,10),0.1)
	add_child(scary)
	var tweenTimer = Timer.new()
	add_child(tweenTimer)
	tweenTimer.wait_time = 0.3
	tweenTimer.start()
	tweenTimer.connect('timeout',credits)

func credits():
	for child in get_children():
		child.queue_free()
	add_child(credits_scene)

func randOffset():
	return Vector2(randf_range(-strength,strength),randf_range(-strength,strength))

func screenshake():
	strength = randi_range(15,30)

func _process(_delta): 
	if strength > 0:
		strength -= 1
	if has_node('Camera2D'):
		$Camera2D.position = randOffset() + Vector2(576, 324)
	
	if has_node("TileMapLayer"):
		$TileMapLayer.position -= Vector2(1,1)
		if $TileMapLayer.position.x < 321:
			$TileMapLayer.position += Vector2(321,321)


func _on_ambiance_finished() -> void:
	if not murder and has_node("Ambiance"):
		$Ambiance.play()
