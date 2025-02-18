extends Node2D
var primary_color : Color = Color(0.1,0.6,0.9)
var secondary_color : Color = Color(0.2,0,0)
var facing_dir = 0
var bounds : Vector4
var move_speed = 1
signal earn_money
@onready var timer: Timer = $Timer

var templates = [preload("res://assets/stripefish.png"),preload("res://assets/catfish.png"),preload("res://assets/maskfish.png"),preload("res://assets/bluntfish.png")]
var temp : int

func _ready() -> void:
	timer.wait_time = randi_range(2,5)
	timer.start()
	$Primary.modulate = primary_color
	$Secondary.modulate = secondary_color
	$Secondary.texture = templates[temp]
	if temp == 3:
		$Secondary.position.x += 60

func _process(delta: float) -> void:
	
	facing_dir += randi_range(-10,10)
	
	position += angle_to_vector(facing_dir) * move_speed
	var half_width = 955 * 0.5 * scale.x
	var half_height = 469 * 0.5 * scale.y
	if position.x < bounds.x or position.y < bounds.y or position.x > bounds.z or position.y > bounds.w:
		facing_dir += 180
		position += angle_to_vector(facing_dir) * move_speed
	rotation = lerp_angle(rotation,deg_to_rad(facing_dir),0.1)
	var true_rotation = abs( roundi( rotation * 180 / PI ) ) % 360
	if true_rotation > 90 and true_rotation < 270:
		$Primary.flip_v = true
		$Secondary.flip_v = true
	else:
		$Primary.flip_v = false
		$Secondary.flip_v = false
	

func angle_to_vector(angle) -> Vector2:
	var angle_radians = deg_to_rad(angle)  # Convert degrees to radians
	var x = cos(angle_radians)
	var y = sin(angle_radians)
	return Vector2(x, y)

func _on_timer_timeout() -> void:
	timer.wait_time = randi_range(2,5)
	earn_money.emit(randi_range(0,2))
