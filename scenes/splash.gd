extends Sprite2D

@onready var anims := $AnimationPlayer
@onready var timer := $Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anims.play("fade_in")
	timer.timeout.connect(_on_timer_timeout)

func _on_timer_timeout():
	anims.play("fade_out")
	await anims.animation_finished
	get_tree().change_scene_to_file("res://scenes/outside_tower.tscn")
