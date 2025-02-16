extends Area2D

signal entered(body, g_self)
signal exited(body, g_self)

@onready var player = $"../player"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	entered.connect(player.food_entered)
	exited.connect(player.food_exited)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func delete():
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	entered.emit(body, self)

func _on_body_exited(body: Node2D) -> void:
	exited.emit(body, self)
