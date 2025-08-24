class_name ObjectInstance extends CharacterBody2D

@export var object_data : ObjectData

@onready var interactable: Interactable = $Interactable
@onready var player : Player = get_tree().get_first_node_in_group("player")


func _ready() -> void:
	interactable.interact = Callable(self, "_on_interact")

func _on_interact():
	player.on_hand = object_data
	call_deferred("queue_free")
