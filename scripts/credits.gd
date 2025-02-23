extends Node2D

@onready var text = $CanvasLayer/RichTextLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CanvasLayer.hide()
	$Phone.hide()


func _on_timer_timeout() -> void:
	$InspectorSong.play()
	await get_tree().create_timer(0.5).timeout
	$CanvasLayer.show()
	await get_tree().create_timer(7.5).timeout
	text.text = "[center]As it tears out your vital organs and you bleed out on the floor...[/center]"
	await get_tree().create_timer(8).timeout
	text.text = "[center]...You see the most terrifying thing of all:[/center]"
	await get_tree().create_timer(8).timeout
	$CanvasLayer.hide()
	await get_tree().create_timer(1.5).timeout
	$Scream.play()
	$Phone.show()
	create_tween().tween_property($Phone, "scale", Vector2(0.5, 0.5), 5).set_trans(Tween.TRANS_QUAD)
	create_tween().tween_property($Phone, "offset", Vector2(575, 400), 5).set_trans(Tween.TRANS_QUAD)
