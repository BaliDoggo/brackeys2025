extends Node2D
var target
signal scare
signal screenshake

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _init() -> void:
	$Scream.play()
	$Timer2.connect('timeout', jumpscare)
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
			$Timer2.start()
		return
	if target.position.y > 600:
		target.queue_free()
		return
	var rot = vector_to_angle(target.position - position)
	rotation = lerp_angle(rotation,rot,0.5)
	position += angle_to_vector(rot) * 5
	if dist(position, target.position) < 20:
		var newSound = AudioStreamPlayer.new()
		newSound.stream = preload("res://assets/524609__clearwavsound__bone-crunch.wav")
		newSound.volume_db = 24
		add_child(newSound)
		newSound.play()
		var newSquish = AudioStreamPlayer.new()
		newSquish.stream = preload("res://assets/fishquish (mp3cut.net).mp3")
		newSquish.volume_db = -25
		add_child(newSquish)
		newSound.play()
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
		var distance = dist(fish.position, position)
		if fish == self or fish.is_queued_for_deletion():
			continue
			
		if distance < mindist:
			mindist = distance
			minfish = fish
	target = minfish

func dist(a,b):
	return sqrt( (a.x - b.x) ** 2 + (a.y - b.y) ** 2 )

func jumpscare():
	connect('scare',get_parent().get_parent().get_parent().jumpscare)
	scare.emit(position)
