class_name Floor extends Node2D

@onready var question_scene := load("res://scenes/Question.tscn")

@onready var question: Question
@onready var ghost: Ghost
@onready var ladder := $Ladder
@onready var ladderAnimPlayer := $Ladder/AnimationPlayer
@onready var player := $Player
@onready var anim_player := $AnimationPlayer
@onready var panel1 := $Panel
@onready var panel2 := $Panel2

func _ready() -> void:
	init_floor()
	if !!question:
		question.correct_answer.connect(_on_correct_answer)
		question.incorrect_answer.connect(_on_incorrect_answer)
	anim_player.play("fade_in")
	player.can_move = false
	anim_player.animation_finished.connect(_on_animation_finished)
	player.climb_floor.connect(_on_floor_climb)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact") && can_interact():
		player.can_move = !player.can_move
		if !question.visible:
			play_ghost_huh()
		question.visible = !question.visible

func can_interact() -> bool:
	var interactable: Area2D = player.interactable
	return !!question && interactable && interactable.name == "GhostTalkArea"
	

func init_floor() -> void:
	question = question_scene.instantiate()
	add_child(question)
	if GameController.current_floor > 1:
		panel1.visible = false
		panel2.visible = false

func dropLadder() -> void:
	ladderAnimPlayer.play("drop ladder")
	$LadderSFX.play()

func _on_correct_answer() -> void:
	player.can_move = true
	GameController.correct_answer()
	dropLadder()
	

func _on_incorrect_answer() -> void: 
	if GameController.current_floor == 1:
		player.can_move = true
		GameController.correct_answer()
		dropLadder()
		return
	GameController.incorrect_answer()
	get_tree().change_scene_to_file("res://scenes/outside_tower.tscn")
	return

func _on_animation_finished(name: String) -> void:
	print(name)
	if name == "fade_in":
		player.can_move = true

func _on_floor_climb() -> void:
	player.can_move = false
	anim_player.play("fade_out")
	await anim_player.animation_finished
	if (GameController.game_won):
		get_tree().change_scene_to_file("res://scenes/roof.tscn")
	else:
		get_tree().change_scene_to_file("res://scenes/floor.tscn")

func play_ghost_huh() -> void:
	%GhostHuh.pitch_scale = randf_range(0.93, 1.1)
	%GhostHuh.play()
