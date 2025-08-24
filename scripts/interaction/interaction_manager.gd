extends Node2D

@onready var player : Player = get_tree().get_first_node_in_group("player")
@onready var label : Label = $Label

const base_text : String = "// E // to "

var active_areas : Array[Interactable] = []
var can_interact : bool = true


func register_area(area : Interactable):
	active_areas.push_back(area)

func unregister_area(area : Interactable):
	var index = active_areas.find(area)
	if index != -1: #checks if index exists in the array
		active_areas.remove_at(index)

func _process(delta: float) -> void:
	if player:
		if player.on_hand and not player.in_machine_range:
			can_interact = false
		else:
			can_interact = true
		
		if active_areas.size() > 0 and can_interact:
			active_areas.sort_custom(_sort_by_distance)
			if not player.on_hand or player.in_machine_range:
				label.text = base_text + active_areas[0].interaction_name
			else:
				label.text = ""
			
			label.global_position = active_areas[0].global_position
			label.global_position.y -= 36
			label.global_position.x -= label.size.x / 2
			label.show()
		else:
			label.hide()

func _sort_by_distance(area1 : Area2D, area2 : Area2D):
	var area1_to_player = player.global_position.distance_to(area1.global_position)
	var area2_to_player = player.global_position.distance_to(area2.global_position)
	return area1_to_player < area2_to_player

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("_interact") and can_interact:
		if active_areas.size() > 0:
			can_interact = false
			label.hide()
			
			await active_areas[0].interact.call()
			can_interact = true
