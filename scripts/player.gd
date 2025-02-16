extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var req_amt = 2
var amt = 0
var g_obj

var in_prox : bool

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("a", "d")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
func collect(g_amt):
	if g_obj != null:
		g_obj.delete()
	if g_amt >= req_amt and in_prox:
		print("sufficient")
	else:
		print("insufficient")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("e"):
		collect(amt + 1)


func food_entered(body, f_self):
	if body == self:
		in_prox = true
		g_obj = f_self

func food_exited(body, f_self):
	if body == self:
		in_prox = false
		g_obj = f_self
