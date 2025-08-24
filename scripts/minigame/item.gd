class_name ItemInstance extends Node2D

@export var item_data : ItemData

@onready var sprite_2d: Sprite2D = $Sprite2D

var is_draggable : bool = false
var dropped_in_crate : bool = false
var sorting_crate : SortingCrate

var initial_position : Vector2
var offset : Vector2


func _ready() -> void:
	#TO-DO: code here to randomize the item upon initialization
	sprite_2d.texture = item_data.item_icon

func _process(delta: float) -> void:
	if is_draggable:
		if Input.is_action_just_pressed("_left_click"):
			initial_position = global_position
			offset = get_global_mouse_position() - global_position
			Global.is_dragging = true
		
		if Input.is_action_pressed("_left_click"):
			global_position = get_global_mouse_position() - offset
		elif Input.is_action_just_released("_left_click"):
			Global.is_dragging = false
			var tween = get_tree().create_tween()
			if dropped_in_crate and sorting_crate.container_type == item_data.item_type:
				tween.tween_property(self, "position", sorting_crate.position + Vector2(0, -7), 0.2).set_ease(Tween.EASE_OUT)
				$AnimationPlayer.play("accepted")
			else:
				tween.tween_property(self, "global_position", initial_position, 0.2).set_ease(Tween.EASE_OUT)
				print("WRONG CONTAINER.")

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("droppable"):
		dropped_in_crate = true
		sorting_crate = body

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("droppable"):
		dropped_in_crate = false

func _on_area_2d_mouse_entered() -> void:
	if not Global.is_dragging:
		is_draggable = true
		scale = Vector2(1.1, 1.1)

func _on_area_2d_mouse_exited() -> void:
	if not Global.is_dragging:
		is_draggable = false
		scale = Vector2(1, 1)
