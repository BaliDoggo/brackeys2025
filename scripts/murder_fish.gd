extends Node2D
var target
signal scare
signal screenshake

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _init() -> void:
	connect('screenshake', get_parent().get_parent().get_parent().screenshake)
	$Primary.queue_free()
	$Secondary.queue_free()
	var tween = create_tween()
	tween.tween_property(self,'scale',Vector2(0.4,0.4),1)
	var ugly = Sprite2D.new()
	ugly.flip_h = true
	ugly.texture = preload("res://assets/image-removebg-preview (1).png")
	add_child(ugly)
	ugly.name = 'ugly'
	target_fish()

func _process(_delta):
	target_fish()
	if not target:
		if $Timer2.is_stopped():
			$Timer2.connect('timeout', jumpscare)
			$Timer2.start()
		return
	var rot = vector_to_angle(target.position - position)
	rotation = lerp_angle(rotation,rot,0.5)
	position += angle_to_vector(rot) * 1.5
	if dist(position, target.position) < 20:
		target.kill()
		screenshake.emit()
	
	var true_rotation = abs( roundi( rotation * 180 / PI ) ) % 360
	if true_rotation > 90 and true_rotation < 270:
		$ugly.flip_v = true
	else:
		$ugly.flip_v = false

func angle_to_vector(angle) -> Vector2:
	var angle_radians = angle  # Convert degrees to radians
	var x = cos(angle_radians)
	var y = sin(angle_radians)
	return Vector2(x, y)

func vector_to_angle(vector) -> float:
	return atan2(vector.y,vector.x)
		
func target_fish():
	var mindist = INF
	var minfish
	for fish in get_parent().get_children():
		var dist = dist(fish.position, position)
		if fish == self or fish.is_queued_for_deletion():
			continue
			
		if dist < mindist:
			mindist = dist
			minfish = fish
	target = minfish

func dist(a,b):
	return sqrt( (a.x - b.x) ** 2 + (a.y - b.y) ** 2 )

func jumpscare():
	connect('scare',get_parent().get_parent().get_parent().jumpscare)
	scare.emit()
