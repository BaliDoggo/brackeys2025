extends Node2D
var tween : Tween = null
signal button_pressed
var money = 0

@onready var chat = $Control/BoxContainer/VBoxContainer/RichTextLabel
@onready var usernames = FileAccess.open("res://assets/FISCH CHAT USERNAMES.txt", FileAccess.READ).get_as_text().split("\n")
@onready var messages = FileAccess.open("res://assets/FISCH CHAT.txt", FileAccess.READ).get_as_text().split("\n")

func _ready() -> void:
	update_label(0)
	for i in range(200):
		update_label(1)

func _process(delta: float) -> void:
	pass

func _on_area_2d_mouse_entered() -> void:
	if tween:
		tween.kill()
	tween = create_tween()
	tween.tween_property(self,"position:x",1070,0.2)


func _on_area_2d_mouse_exited() -> void:
	if tween:
		tween.kill()
	tween = create_tween()
	tween.tween_property(self,"position:x",1220,0.2)


func _on_button_pressed() -> void:
	if money < 1:
		return
	
	update_label(-1)
	button_pressed.emit(1)

func _on_button_2_pressed() -> void:
	if money < 10:
		return
	
	update_label(-10)
	button_pressed.emit(2)

func _on_button_3_pressed() -> void:
	if money < 100:
		return
	
	update_label(-100)
	button_pressed.emit(3)
	
func update_label(amount):
	money += amount
	$Control/BoxContainer/VBoxContainer/Label.text = '$' + str(money)
	
	if amount > 0:
		var rand_color = Color(randf(),randf(),randf())
		var color_hex = (rand_color.to_html(false))
		$Control/BoxContainer/VBoxContainer/RichTextLabel.append_text("\n [color=" + str(color_hex) +"]"+ get_username() +": [/color]" + get_message())

func _on_button_mouse_entered() -> void:
	$Control/BoxContainer/Button.get_child(0).show()
	
func _on_button_mouse_exited() -> void:
	$Control/BoxContainer/Button.get_child(0).hide()

func _on_button_2_mouse_entered() -> void:
	$Control/BoxContainer/Button2.get_child(0).show()
	

func _on_button_2_mouse_exited() -> void:
	$Control/BoxContainer/Button2.get_child(0).hide()

func _on_button_3_mouse_entered() -> void:
	$Control/BoxContainer/Button3.get_child(0).show()
	
func _on_button_3_mouse_exited() -> void:
	$Control/BoxContainer/Button3.get_child(0).hide()

func get_username():
	var user = Array(usernames).pick_random()
	if user != "":
		return user
	return get_username()

func get_message():
	var message = Array(messages).pick_random()
	if message != "":
		return message
	return get_username()
