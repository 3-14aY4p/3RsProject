class_name UnsortedCrate extends StaticBody2D

@onready var spawn_point: Marker2D = $SpawnPoint
@onready var label: Label = $Label

@export var max_spawn_amount : int = 3
var spawn_amount : int
var item_instance
var can_new_item : bool = true
var current_item : ItemInstance


func _ready() -> void:
	spawn_amount = max_spawn_amount

func _physics_process(delta: float) -> void:
	if not current_item and not spawn_amount == 0:
		item_instance = load("res://scenes/minigame/item_instance.tscn").instantiate()
		
		current_item = item_instance
		current_item.global_position = spawn_point.global_position
		get_parent().get_node("UnsortedItemsContainer").add_child(current_item)
		
		label.text = current_item.item_data.item_name
		
		var tween = get_tree().create_tween()
		tween.tween_property(current_item, "global_position", current_item.global_position + Vector2(0, -44), 0.2).set_ease(Tween.EASE_OUT)
		
		spawn_amount -= 1
		
	elif not current_item:
		Global.game_controller.change_gui_scene("res://scenes/control/empty.tscn")
