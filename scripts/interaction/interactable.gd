class_name Interactable extends Area2D

@export var interaction_name : String = ""

var interact : Callable = func():
	pass


func _on_body_entered(body: Node2D) -> void:
	InteractionManager.register_area(self)

func _on_body_exited(body: Node2D) -> void:
	InteractionManager.unregister_area(self)
	Global.interaction_name = ""

#INITALIZING INTERACTABLE IN ANOTHER SCRIPT:
#func _ready() -> void:
	#interactable.interact = Callable(self, "_on_interact")
