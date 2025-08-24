extends StaticBody2D

@onready var interactable: Interactable = $Interactable
@onready var player : Player = get_tree().get_first_node_in_group("player")

var player_in_range : bool = false


func _ready() -> void:
	interactable.interact = Callable(self, "_on_interact")

func _on_interact():
	if player.on_hand:
		if player.on_hand.obj_name == "crate":
			Global.game_controller.change_2d_scene("res://scenes/minigame/levels/sorting_minigame.tscn", false, false)

func _on_interactable_body_entered(body: Node2D) -> void:
	if body == player:
		player.in_machine_range = true

func _on_interactable_body_exited(body: Node2D) -> void:
	if body == player:
		player.in_machine_range = false
