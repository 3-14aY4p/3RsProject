extends Control

@onready var interaction_label: Label = $CanvasLayer/InteractionLabel
@onready var score_label: Label = $CanvasLayer/ScoreLabel

@onready var player : Player = get_tree().get_first_node_in_group("player")


func _process(delta: float) -> void:
	if Global.interaction_name:
		interaction_label.text = "// E // " + Global.interaction_name
	else:
		interaction_label.text = ""
		
	score_label.text = "quota: " + str(Global.currency)
