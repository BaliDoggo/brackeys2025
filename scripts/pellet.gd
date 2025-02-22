extends Node2D
var type : int
var held = true
var amount : int
var speed : float = 3
signal eaten
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if amount <= 0:
		queue_free()
	if type == 1:
		$Sprite2D.texture = preload("res://assets/basic-pellet.png")
	if type == 2:
		$Sprite2D.texture = preload("res://assets/primo-pellet.png")
	if type == 3:
		$Sprite2D.texture = preload("res://assets/delux-pellet.png")
		$Sprite2D.z_index = 1
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if held:
		position = get_global_mouse_position()
		
		if position.y < 118 and position.x > 90 and position.x < 1062:
			$Label.hide()
			if Input.is_action_just_released("click"):
				held = false
				get_parent().new_food(type,amount - 1,position)
				
				if type == 3:
					for i in range(10):
						var newShine = Sprite2D.new()
						newShine.texture = preload("res://assets/Sprite-0001.png")
						newShine.modulate = Color(1 , 1 - i/10.0, 1 , i/10.0)
						newShine.scale *= 10 - i
						add_child(newShine)
		
		else:
			$Label.show()
			
	else:
		$Label.hide()
		position.y += speed
		if position.y > 300:
			var opacity = (500 - position.y) if type != 3 else 999.0
			$Sprite2D.modulate = Color($Sprite2D.modulate, opacity / 200.0)
			
		if position.y > 500:
			if type == 3:
				speed = -3
				return
			queue_free()
		
		if position.y < 118 and type == 3 and speed < 0:
			speed = 3
		
		
		


func _on_area_2d_area_entered(area: Area2D) -> void:
	if not held:
		eaten.emit(area,type)
		queue_free()

func tutorial():
	pass
