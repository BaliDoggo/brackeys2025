extends Node2D
var tween : Tween = null
signal button_pressed



func _on_area_2d_mouse_entered() -> void:
	if tween:
		tween.kill()
	tween = create_tween()
	tween.tween_property(self,"position:y",600,0.2)


func _on_area_2d_mouse_exited() -> void:
	if tween:
		tween.kill()
	tween = create_tween()
	tween.tween_property(self,"position:y",708,0.2)


func _on_button_pressed() -> void:
	button_pressed.emit(1)

func _on_button_2_pressed() -> void:
	button_pressed.emit(2)

func _on_button_3_pressed() -> void:
	button_pressed.emit(3)
	
func update_label(amount):
	$Control/BoxContainer/VBoxContainer/Label.text = '$' + str(amount)
