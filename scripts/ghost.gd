class_name Ghost extends Node2D

@export var ghost_name := ""



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(ghost_name)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
