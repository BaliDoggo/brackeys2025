extends Node2D
signal food_eaten_signal
@onready var food = preload("res://scenes/pellet.tscn")

func _on_button_pressed() -> void:
	if get_child_count() < 4:
		new_food(1, int($Button2/Label.text))
		$Button3/Label.text = '0'

func _on_button_2_pressed() -> void:
	if get_child_count() < 4:
		new_food(2, int($Button2/Label.text))
		$Button2/Label.text = '0'
		
func _on_button_3_pressed() -> void:
	if get_child_count() < 4:
		var num = int($Button3/Label.text)
		print(num)
		new_food(3, min(num, 1))
		if num > 0:
			$Button3.disconnect("pressed",_on_button_3_pressed)
		$Button3/Label.text = '0'
		
		
func food_purchased(type):
	var label = get_child( type - 1 ).get_child(0)
	label.text = str(int(label.text) + 1)

func new_food(num,amnt):
	var newFood = food.instantiate()
	newFood.type = num
	newFood.amount = amnt
	newFood.connect('eaten',food_eaten)
	add_child(newFood)

func food_eaten(fish,type):
	food_eaten_signal.emit(fish,type)
