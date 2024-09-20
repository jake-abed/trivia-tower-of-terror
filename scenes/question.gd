class_name Question extends Panel

@export var intro_text := ""
@export var question := ""
@export var answer := ""
@export var hint := ""
@export var options := ["", "", "", ""]

@onready var question_label := $QuestionLabel
@onready var answer_1 := $VBoxContainer/Row1/Answer1
@onready var answer_2 := $VBoxContainer/Row1/Answer2
@onready var answer_3 := $VBoxContainer/Row2/Answer3
@onready var answer_4 := $VBoxContainer/Row2/Answer4

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	init_question()
	populate_ui()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func init_question() -> void:
	var possible_questions: Array = GameController.all_questions[GameController.current_difficulty]
	var rand_question: Dictionary = possible_questions.pick_random()
	question = rand_question["question"]
	answer = rand_question["answer"]
	hint = rand_question["answer"]
	var copy_of_options: Array = rand_question["options"].duplicate(true)
	copy_of_options.shuffle()
	options = copy_of_options

func populate_ui() -> void:
	question_label.text = question
	answer_1.text = options[0]
	answer_2.text = options[1]
	answer_3.text = options[2]
	answer_4.text = options[3]
