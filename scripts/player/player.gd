class_name Player extends CharacterBody2D

@onready var interaction_manager: Node2D = $InteractionManager

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var item_sprite: Sprite2D = $Sprite2D/ItemSprite
@onready var hand_sprite: Sprite2D = $Sprite2D/HandSprite

@export var max_speed : float = 75.0
var speed : float

var collisions_in_range : Array = []
var on_hand : ObjectData
var can_drop_object : bool = false

var in_machine_range : bool = false


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("_interact"):
		if on_hand and can_drop_object:
			var object_instance = load(on_hand.obj_path).instantiate()
			object_instance.global_position = global_position + Vector2(0, 10)
			get_parent().get_node("ObjectContainer").add_child(object_instance)
			
			on_hand = null

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	if collisions_in_range or in_machine_range:
		can_drop_object = false
	else:
		can_drop_object = true
	
	velocity = Input.get_vector("_left", "_right", "_up", "_down") * speed
	move_and_slide()
	
	if not on_hand:
		speed = max_speed
		item_sprite.texture = null
		hand_sprite.hide()
	elif on_hand:
		speed = max_speed / 2
		item_sprite.texture = on_hand.obj_icon
		hand_sprite.show()
	
	if velocity == Vector2.ZERO:
		animation_player.play("idle")
	else:
		animation_player.play("walk")
	
	if velocity.x > 0:
		sprite_2d.flip_h = false
		item_sprite.position.x = 4
		hand_sprite.position.x = 4
	elif velocity.x < 0:
		sprite_2d.flip_h = true
		item_sprite.position.x = -4
		hand_sprite.position.x = -4

func _on_placement_area_body_entered(body: Node2D) -> void:
	collisions_in_range.push_back(body)

func _on_placement_area_body_exited(body: Node2D) -> void:
	collisions_in_range.erase(body)
