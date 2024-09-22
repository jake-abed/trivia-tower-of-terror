extends Node2D

@onready var player := $Player
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if GameController.floor_drop > 0:
		player.global_position.x = 425
		player.global_position.y = 300 - (GameController.floor_drop * 60)
	player.enter_tower.connect(_on_enter_tower)

func _process(delta: float) -> void:
	pass

func _on_enter_tower() -> void:
	$CanvasModulate/AnimationPlayer.play("fade_out")
	$CanvasLayer/UI/TowerSign.visible = false
	await $CanvasModulate/AnimationPlayer.animation_finished
	get_tree().change_scene_to_file("res://scenes/floor.tscn")
