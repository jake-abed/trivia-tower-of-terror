class_name Floor extends Node2D

@onready var question_scene := load("res://scenes/Question.tscn")

@onready var question: Question
@onready var ghost: Ghost

func _ready() -> void:
	init_floor()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept") && !!question:
		question.visible = !question.visible

func init_floor() -> void:
	question = question_scene.instantiate()
	add_child(question)
