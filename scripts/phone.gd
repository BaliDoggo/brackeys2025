extends Node2D
var tween : Tween = null
signal button_pressed
var money = 20


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
	if money < 2:
		return
	
	update_label(-2)
	button_pressed.emit(1)

func _on_button_2_pressed() -> void:
	if money < 200:
		return
	
	update_label(-10)
	button_pressed.emit(2)

func _on_button_3_pressed() -> void:
	if money < 2000:
		return
	
	update_label(-1000)
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
