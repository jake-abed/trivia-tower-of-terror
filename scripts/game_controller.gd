extends Node

@onready var current_difficulty := "easy"
@onready var all_questions: Dictionary
@onready var easy_questions: Array
@onready var medium_questions: Array
@onready var hard_questions: Array
@onready var score := 0
@onready var health := 25
@onready var current_floor := 1
@onready var floor_drop := 0
@onready var game_won := false

var already_asked = []

func _ready() -> void:
	all_questions = load_questions()
	easy_questions = all_questions["easy"]
	medium_questions = all_questions["medium"]
	hard_questions = all_questions["hard"]
	

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

func correct_answer() -> void:
	if current_floor == 5 || current_floor == 9:
		increase_difficulty()
	if current_floor == 12:
		game_won = true
	current_floor += 1
	score += 1

func incorrect_answer() -> void:
	if current_floor == 1:
		correct_answer()
		return
	already_asked = []
	current_difficulty = "easy"
	floor_drop = current_floor - 1
	health -= floor_drop
	current_floor = 1
	score = 0
	return
