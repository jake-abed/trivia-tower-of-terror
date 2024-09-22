class_name Floor extends Node2D

@onready var question_scene := load("res://scenes/Question.tscn")

@onready var question: Question
@onready var ghost: Ghost
@onready var ladder := $Ladder
@onready var ladderAnimPlayer := $Ladder/AnimationPlayer
@onready var player := $Player

func _ready() -> void:
	init_floor()
	if !!question:
		question.correct_answer.connect(_on_correct_answer)
		question.incorrect_answer.connect(_on_incorrect_answer)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept") && !!question && player.interactable.name == "GhostTalkArea":
		player.can_move = !player.can_move
		question.visible = !question.visible

func init_floor() -> void:
	question = question_scene.instantiate()
	add_child(question)

func dropLadder() -> void:
	ladderAnimPlayer.play("drop ladder")

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
