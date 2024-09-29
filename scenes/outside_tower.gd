extends Node2D

@onready var player := $Player
@onready var health_label := $HealthPanel/HealthLabel
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if GameController.floor_drop > 0:
		player.global_position.x = 425
		player.global_position.y = 300 - (GameController.floor_drop * 60)
		$GhostLaughter.pitch_scale = randf_range(1.0, 1.2)
		$GhostLaughter.play()
	player.enter_tower.connect(_on_enter_tower)
	player.just_died.connect(_player_died)
	health_label.text = str(GameController.health)

func _process(delta: float) -> void:
	pass

func _on_enter_tower() -> void:
	$CanvasModulate/AnimationPlayer.play("fade_out")
	$CanvasLayer/UI/TowerSign.visible = false
	await $CanvasModulate/AnimationPlayer.animation_finished
	get_tree().change_scene_to_file("res://scenes/floor.tscn")

func _player_died() -> void:
	var tween := create_tween()
	tween.tween_property($AudioStreamPlayer2D, "volume_db", -80.0, 2)
	tween.play()
	$GameOverSound.play()
