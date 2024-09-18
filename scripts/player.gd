extends CharacterBody2D

const SPEED := 300.0
const JUMP_VELOCITY := -400.0

@export var sprite: Sprite2D
@export var anim_tree: AnimationTree

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

	move_and_slide()

func set_sprite_direction() -> void:
	if velocity.x < 0:
		sprite.flip_h = true
	if velocity.x > 0:
		sprite.flip_h = false
	else: pass
