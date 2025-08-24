class_name SortingCrate extends StaticBody2D

@onready var label: Label = $Label

@export var container_type : String = ""


func _ready() -> void:
	label.text = container_type
