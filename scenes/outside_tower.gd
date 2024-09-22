extends Node2D

@onready var player := $Player
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if GameController.floor_drop > 0:
		player.global_position.x = 425
		player.global_position.y = 300 - (GameController.floor_drop * 60)

func _process(delta: float) -> void:
	pass
