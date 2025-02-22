extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$GPUParticles2D.amount = scale.x * 1000
	$GPUParticles2D.emitting = true
	$GPUParticles2D2.texture = [preload("res://assets/meat2-removebg-preview.png"), preload("res://assets/meat1-removebg-preview.png"), preload("res://assets/meat3bg-removebg-preview.png")].pick_random()
	$GPUParticles2D3.texture = [preload("res://assets/meat2-removebg-preview.png"), preload("res://assets/meat1-removebg-preview.png"), preload("res://assets/meat3bg-removebg-preview.png")].pick_random()
	$GPUParticles2D4.texture = [preload("res://assets/meat2-removebg-preview.png"), preload("res://assets/meat1-removebg-preview.png"), preload("res://assets/meat3bg-removebg-preview.png")].pick_random()
	$GPUParticles2D2.emitting = true
	$GPUParticles2D3.emitting = true
	$GPUParticles2D4.emitting = true
