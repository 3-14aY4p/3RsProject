class_name Player extends CharacterBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D

@export var max_speed : float = 75.0
var speed : float

var is_carrying : bool = false


func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	velocity = Input.get_vector("_left", "_right", "_up", "_down") * speed
	move_and_slide()
	
	if not is_carrying:
		speed = max_speed
	elif is_carrying:
		speed = max_speed / 2
	
	if velocity == Vector2.ZERO:
		animation_player.play("idle")
	else:
		animation_player.play("walk")
	
	if velocity.x > 0:
		sprite_2d.flip_h = false
	elif velocity.x < 0:
		sprite_2d.flip_h = true
