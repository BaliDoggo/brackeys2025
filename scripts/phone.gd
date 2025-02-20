extends Node2D
var tween : Tween = null
signal button_pressed
var money = 2000

@onready var chat = $Control/BoxContainer/VBoxContainer/RichTextLabel
@onready var usernames = FileAccess.open("res://assets/FISCH CHAT USERNAMES.txt", FileAccess.READ)
@onready var messages = FileAccess.open("res://assets/FISCH CHAT.txt", FileAccess.READ)
@onready var usernames_array = FileAccess.open("res://assets/chat_array.txt", FileAccess.READ).get_as_text()
@onready var messages_array = FileAccess.open("res://assets/message_array.txt", FileAccess.READ).get_as_text()


func _ready() -> void:
	update_label(0)

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

func get_chat():
	chat.append_text("\n [b]" + str(get_username()) + "[/b]  " + str(get_message()))

func get_username():
	return str_to_var(usernames_array).pick_random()

func get_message():
	return str_to_var(messages_array).pick_random()
