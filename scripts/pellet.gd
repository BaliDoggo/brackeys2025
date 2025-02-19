extends Node2D
var type : int
var held = true
var amount : int
signal eaten
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if amount <= 0:
		queue_free()
	if type == 2:
		modulate = Color.RED
	if type == 3:
		modulate = Color.GREEN


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if held:
		position = get_global_mouse_position()
		
		if Input.is_action_just_released("click") and position.y < 118:
			held = false
			get_parent().new_food(type,amount - 1)
			
	else:
		position.y += 3
		if position.y > 300:
			var opacity = 500 - position.y
			$Sprite2D.modulate = Color($Sprite2D.modulate,opacity / 200)
			
		if position.y > 500:
			queue_free()
		


func _on_area_2d_area_entered(area: Area2D) -> void:
	if not held:
		eaten.emit(area,type)
		queue_free()
