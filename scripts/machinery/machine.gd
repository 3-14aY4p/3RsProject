extends StaticBody2D

@onready var interactable: Interactable = $Interactable
@onready var player : Player = get_tree().get_first_node_in_group("player")

@onready var spawn_marker: Marker2D = $ItemProcessingComponent/SpawnMarker
@onready var timer: Timer = $ItemProcessingComponent/Timer
@onready var progress_bar: ProgressBar = $ItemProcessingComponent/ProgressBar

@export var container_type : String = ""
@export var box_produced : String = ""

var player_in_range : bool = false
var is_processing : bool = false


func _ready() -> void:
	progress_bar.hide()
	
	interactable.interact = Callable(self, "_on_interact")
	
	progress_bar.min_value = 0
	progress_bar.max_value = timer.wait_time

func _process(delta: float) -> void:
	progress_bar.value = timer.time_left
	
	if is_processing:
		interactable.monitoring = false
	else:
		interactable.monitoring = true

func _on_interact():
	if player.on_hand and not is_processing:
		if player.on_hand.obj_name == container_type:
			player.on_hand = null
			timer.start()
			progress_bar.show()
			
			is_processing = true

func _on_interactable_body_entered(body: Node2D) -> void:
	if body == player and not is_processing:
		player.in_machine_range = true

func _on_interactable_body_exited(body: Node2D) -> void:
	if body == player:
		player.in_machine_range = false

func _on_timer_timeout() -> void:
	progress_bar.hide()
	timer.stop()
	
	var box_instance = load(box_produced).instantiate()
	box_instance.global_position = spawn_marker.global_position
	get_parent().get_parent().get_node("ObjectContainer").add_child(box_instance)
	
	is_processing = false
	
