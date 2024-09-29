extends Node2D

@onready var player := $Player
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.open_chest.connect(_open_da_chest)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _open_da_chest() -> void:
	$ChestPanel.visible = true
	player.can_move = false
