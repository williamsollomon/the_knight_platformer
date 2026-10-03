extends Area2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

signal player_died
const SPEED = 30.0
var direction = 1.0
var has_attacked: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not has_attacked:
		position.x += direction * SPEED * delta


func _on_timer_timeout() -> void:
	if has_attacked:
		return
	direction *= -1
	animated_sprite_2d.flip_h=!animated_sprite_2d.flip_h


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player" and body.alive and not has_attacked:
		has_attacked = true 
		
		if body.global_position.x < global_position.x:
			animated_sprite_2d.flip_h = true #kiri
		else:
			animated_sprite_2d.flip_h = false #kanan
			
		animated_sprite_2d.play("attack")
		emit_signal("player_died", body)
