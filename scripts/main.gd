extends Node2D
var fish_tank = preload("res://scenes/fish_tank.tscn").instantiate()
var phone = preload("res://scenes/phone.tscn").instantiate()
var food = preload("res://scenes/food.tscn").instantiate()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	fish_tank.connect("update_label_signal", phone.update_label)
	phone.connect("button_pressed",fish_tank.button_pressed)
	add_child(fish_tank)
	add_child(phone)
	add_child(food)
