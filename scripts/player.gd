class_name Player extends CharacterBody2D

const SPEED := 200.0

@export var sprite: Sprite2D
@export var anim_tree: AnimationTree

var interactable: Area2D
var can_move := true
var in_air := false

func _ready() -> void:
	anim_tree.active = true

func _physics_process(delta: float) -> void:
	set_sprite_direction()
	anim_tree.set("parameters/move/blend_position", velocity.x)
	
	if not is_on_floor():
		in_air = true
		velocity += get_gravity() * delta
	
	if is_on_floor() && !!in_air:
		if GameController.health <= 0:
			die()
		in_air = false

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction && can_move:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if Input.is_action_just_pressed("ui_accept"):
		interact()
	
	move_and_slide()

func set_sprite_direction() -> void:
	if velocity.x < 0:
		sprite.flip_h = true
	if velocity.x > 0:
		sprite.flip_h = false
	else: pass

func interact() -> void:
	if !interactable:
		return
	match interactable.name:
		"TowerEntryPoint":
			enter_tower()
		"GhostTalkArea":
			print("Talking to ghost...")
		"LadderArea":
			next_floor()
		_:
			print("Unmatched case")

func enter_tower():
	get_tree().change_scene_to_file("res://scenes/floor.tscn")

func next_floor():
	get_tree().change_scene_to_file("res://scenes/floor.tscn")

func die() -> void:
	queue_free()
