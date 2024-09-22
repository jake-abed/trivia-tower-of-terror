class_name Question extends Panel

signal correct_answer
signal incorrect_answer

@export var intro_text := ""
@export var question := ""
@export var answer := ""
@export var hint := ""
@export var options := ["", "", "", ""]

@onready var question_label := %QuestionLabel
@onready var answer_1 := %Answer1
@onready var answer_2 := %Answer2
@onready var answer_3 := %Answer3
@onready var answer_4 := %Answer4
@onready var hint_label := %Hint

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	init_question()
	populate_ui()
	answer_1.pressed.connect(_answer_pressed.bind(answer_1.text))
	answer_2.pressed.connect(_answer_pressed.bind(answer_2.text))
	answer_3.pressed.connect(_answer_pressed.bind(answer_3.text))
	answer_4.pressed.connect(_answer_pressed.bind(answer_4.text))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func init_question() -> void:
	var possible_questions: Array = GameController.all_questions[GameController.current_difficulty]
	possible_questions = possible_questions.filter(question_already_asked)
	print(GameController.already_asked)
	var rand_question: Dictionary = possible_questions.pick_random()
	GameController.already_asked.append(rand_question["question"])
	question = rand_question["question"]
	answer = rand_question["answer"]
	hint = rand_question["hint"]
	var copy_of_options: Array = rand_question["options"].duplicate(true)
	copy_of_options.shuffle()
	options = copy_of_options

func question_already_asked(question: Dictionary) -> bool:
	return (!GameController.already_asked.has(question["question"]))

func populate_ui() -> void:
	question_label.text = question
	answer_1.text = options[0]
	answer_2.text = options[1]
	answer_3.text = options[2]
	answer_4.text = options[3]
	hint_label.tooltip_text = hint

func _answer_pressed(button_value: String) -> void:
	if button_value == answer:
		correct_answer.emit()
	else:
		incorrect_answer.emit()
	self.queue_free()
