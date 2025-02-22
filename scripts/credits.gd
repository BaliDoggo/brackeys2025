extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CanvasLayer.hide()


func _on_timer_timeout() -> void:
	$InspectorSong.play()
	$CanvasLayer.show()
