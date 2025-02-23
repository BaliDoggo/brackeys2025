extends Node2D
signal food_eaten_signal
@onready var food = preload("res://scenes/pellet.tscn")

func _on_button_pressed() -> void:
	if get_child_count() < 4:
		new_food(1, int($HBoxContainer/Button/Label.text), get_global_mouse_position())
		$HBoxContainer/Button/Label.text = '0'

func _on_button_2_pressed() -> void:
	if get_child_count() < 4:
		new_food(2, int($HBoxContainer/Button2/Label.text), get_global_mouse_position())
		$HBoxContainer/Button2/Label.text = '0'
		
func _on_button_3_pressed() -> void:
	if get_child_count() < 4:
		var num = int($HBoxContainer/Button3/Label.text)
		print(num)
		new_food(3, min(num, 1), get_global_mouse_position())
		if num > 0:
			$HBoxContainer/Button3.disconnect("pressed",_on_button_3_pressed)
		$HBoxContainer/Button3/Label.text = '0'
		
		
func food_purchased(type):
	var label = $HBoxContainer.get_child( type - 1 ).get_child(0)
	label.text = str(int(label.text) + 1)
	$AudioStreamPlayer2D.play()

func new_food(num,amnt,pos):
	var newFood = food.instantiate()
	newFood.type = num
	newFood.position = pos
	newFood.amount = amnt
	newFood.connect('eaten',food_eaten)
	add_child(newFood)

func food_eaten(fish,type):
	var newSound = AudioStreamPlayer.new()
	newSound.stream = preload("res://assets/353067__jofae__bite-cartoon-style.mp3")
	newSound.volume_db = -25
	add_child(newSound)
	newSound.play()
	newSound.connect('finished', newSound.queue_free)
	food_eaten_signal.emit(fish,type)
