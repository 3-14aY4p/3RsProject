extends Node2D

@onready var spawn_marker: Marker2D = $SpawnMarker


func _ready() -> void:
	if not get_tree().get_nodes_in_group("player"):
		var player = load("res://scenes/player/player.tscn").instantiate()
		player.global_position = spawn_marker.global_position
		add_child(player)
