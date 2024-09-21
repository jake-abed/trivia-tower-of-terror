class_name Player extends CharacterBody2D

const SPEED := 200.0

@export var sprite: Sprite2D
@export var anim_tree: AnimationTree

var interactable: Area2D

func _ready() -> void:
	anim_tree.active = true

func _physics_process(delta: float) -> void:
	set_sprite_direction()
	anim_tree.set("parameters/move/blend_position", velocity.x)
	
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
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
			print("Talk to ghost")
		"LadderArea":
			print("Go up ladder")
		_:
			print("Unmatched case")

func enter_tower():
	print("This would cause tower entry")
