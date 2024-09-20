extends Node

@onready var current_difficulty := "easy"
@onready var all_questions: Dictionary
@onready var easy_questions: Array
@onready var medium_questions: Array
@onready var hard_questions: Array

func _ready() -> void:
	all_questions = load_questions()
	easy_questions = all_questions["easy"]
	medium_questions = all_questions["medium"]
	hard_questions = all_questions["hard"]
	print(medium_questions)
	

func load_questions() -> Dictionary:
	var file = FileAccess.open("res://data/questions.json", FileAccess.READ)
	var raw_data := file.get_as_text()
	
	var json = JSON.new()
	var error := json.parse(raw_data)
	if error == OK:
		if typeof(json.data) == TYPE_DICTIONARY:
			return json.data
		else: return { "unknown_data_type": true }
	else: return { "unknown_data_type": true }

func increase_difficulty() -> void:
	match current_difficulty:
		"easy":
			current_difficulty = "medium"
		"medium":
			current_difficulty = "hard"
		_:
			current_difficulty = "hard"

func decrease_difficulty() -> void:
	match current_difficulty:
		"hard":
			current_difficulty = "medium"
		"medium":
			current_difficulty = "easy"
		_:
			current_difficulty = "easy"
