extends Node2D
signal food_pressed
@onready var food = preload("res://scenes/pellet.tscn").instantiate()

func _on_button_pressed() -> void:
	food.type = 1
	add_child(food)

func _on_button_2_pressed() -> void:
	food.type = 2
	add_child(food)

func _on_button_3_pressed() -> void:
	food.type = 3
	add_child(food)

func _on_food_dropped() -> void:
	pass
