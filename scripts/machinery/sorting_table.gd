extends StaticBody2D

@onready var interactable: Interactable = $Interactable
@onready var player : Player = get_tree().get_first_node_in_group("player")
@onready var marker_2d: Marker2D = $Marker2D

var player_in_range : bool = false


func _ready() -> void:
	interactable.interact = Callable(self, "_on_interact")

func _on_interact():
	if player.on_hand:
		if player.on_hand.obj_name == "crate":
			player.on_hand = null
			Global.game_controller.change_gui_scene("res://scenes/minigame/levels/sorting_minigame.tscn")
			
			var sorted_crates_instance = load("res://scenes/containers/sorted_crates_container.tscn").instantiate()
			sorted_crates_instance.global_position = marker_2d.global_position
			get_parent().get_parent().get_node("ObjectContainer").add_child(sorted_crates_instance)
			
			#instantiate product cratess

func _on_interactable_body_entered(body: Node2D) -> void:
	if body == player:
		player.in_machine_range = true

func _on_interactable_body_exited(body: Node2D) -> void:
	if body == player:
		player.in_machine_range = false
