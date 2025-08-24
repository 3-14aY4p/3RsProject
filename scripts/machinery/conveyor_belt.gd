extends StaticBody2D

@onready var spawn_point: Marker2D = $SpawnPoint
@onready var spawn_timer: Timer = $SpawnTimer

@export var spawn_interval : float = 10
@export var spawn_count : int = 5

var on_platform : Array[ObjectInstance] = []
var on_slope : Array[ObjectInstance] = []


func _ready() -> void:
	spawn_timer.wait_time = spawn_interval

func _physics_process(delta: float) -> void:
	for object in on_platform:
		object.global_position.x += 8 * delta
		
	for object in on_slope:
		object.global_position.y += 1 * delta

func _on_platform_body_entered(body: Node2D) -> void:
	if body.is_in_group("object"):
		on_platform.push_back(body)

func _on_platform_body_exited(body: Node2D) -> void:
	if body.is_in_group("object"):
		on_platform.erase(body)

func _on_slope_body_entered(body: Node2D) -> void:
	if body.is_in_group("object"):
		on_slope.push_back(body)

func _on_slope_body_exited(body: Node2D) -> void:
	if body.is_in_group("object"):
		on_slope.erase(body)

func _on_spawn_timer_timeout() -> void:
	if spawn_count > 0:
		var object_instance = load("res://scenes/objects/crate.tscn").instantiate()
		object_instance.position = spawn_point.global_position
		get_parent().get_parent().get_node("ObjectContainer").add_child(object_instance)
		
		spawn_count -= 1
