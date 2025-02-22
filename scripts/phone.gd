extends Node2D
var tween : Tween = null
signal button_pressed
var money = 0
var panic = false
var shook : Vector2

@onready var chat = $Control/BoxContainer/VBoxContainer/RichTextLabel
@onready var usernames = FileAccess.open("res://assets/FISCH CHAT USERNAMES.txt", FileAccess.READ).get_as_text().split("\n")
@onready var messages = FileAccess.open("res://assets/FISCH CHAT.txt", FileAccess.READ).get_as_text().split("\n")

func _ready() -> void:
	update_label(0)
	$Control/BoxContainer/VBoxContainer/RichTextLabel.append_text("WELCOME_BOT: [color=#ff00ff]Thanks for streaming! Fans will give you donations, which you can use for purchasing food with our handy interface! You'll be famous in no time![/color]")
	$Control/BoxContainer/VBoxContainer/RichTextLabel.append_text("\nFishTrainer: [color=#000099]Fish are pretty dumb, make sure you drop the food into their mouths, or they'll miss it![/color]")
	
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
	if panic:
		return
	
	money += amount
	$Control/BoxContainer/VBoxContainer/Label.text = '$' + str(money)
	
	if amount > 0:
		var rand_color = Color(randf(),randf(),randf())
		var color_hex = (rand_color.to_html(false))
		$Control/BoxContainer/VBoxContainer/RichTextLabel.append_text("\n [color=" + str(color_hex) +"]"+ get_username() +": [/color]" + get_message())

func begin_panic():
	panic = true
	$Timer.connect('timeout', blood)
	$Timer.start()
	
func blood():
	if shook.y != 0:
		if not tween.is_running():
			position = shook
		shook = Vector2(0,0)
	else:
		if not tween.is_running():
			shook = position
		position += Vector2(randf_range(-5,5),randf_range(-5,5))
		
	money -= 1
	$Control/BoxContainer/VBoxContainer/Label.text = '$' + str(money)
	$Control/BoxContainer/VBoxContainer/RichTextLabel.append_text("\n [color=#ff0000]"+ get_username() +": [/color] blood.")

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
	return get_message()

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("a"):
		update_label(2000)
