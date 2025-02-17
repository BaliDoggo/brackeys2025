extends Node2D
var primary_color : Color = Color(0.1,0.6,0.9)
var secondary_color : Color = Color(0.2,0,0)
var facing_dir = 0
var bounds : Vector4
signal earn_money
@onready var timer: Timer = $Timer

func _ready() -> void:
	timer.wait_time = randi_range(2,5)
	timer.start()
	$Primary.modulate = primary_color
	$Secondary.modulate = secondary_color

func _process(delta: float) -> void:
	
	facing_dir += randi_range(-10,10)
	
	position += angle_to_vector(facing_dir)
	if position.x < bounds.x or position.y < bounds.y or position.x > bounds.z or position.y > bounds.w:
		facing_dir += 180
	rotation = lerp_angle(rotation,deg_to_rad(facing_dir),0.1)

func angle_to_vector(angle) -> Vector2:
	var angle_radians = deg_to_rad(angle)  # Convert degrees to radians
	var x = cos(angle_radians)
	var y = sin(angle_radians)
	return Vector2(x, y)

func _on_timer_timeout() -> void:
	timer.wait_time = randi_range(2,5)
	earn_money.emit(randi_range(0,2))
