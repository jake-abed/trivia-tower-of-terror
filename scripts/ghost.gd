class_name Ghost extends Node2D

var all_intros = [
	"Hrmmmm... lemme ask you a question!",
	"You look smart... but how smart?",
	"If you get my trivia question wrong, I'll show you how I died...",
	"Climb or die, but you have to answer my question!",
	"Ugh, I'm so tired of asking trivia questions...",
	"Bet you didn't know a ghost could smell bad!",
	"My favorite food was mac & cheese when I was alive. Now it's fear!",
	"Now that I'm dead, I don't understand object permanence.",
	"Where are you? My eyesight is bad, but my trivia is good."
]

@onready var intro: String = all_intros.pick_random()
@onready var talk_area := $GhostTalkArea
@onready var dialog_panel := $Panel
@onready var dialog_label := $Panel/Label

func _ready() -> void:
	ghosty_float()
	dialog_label.text = intro
	talk_area.body_entered.connect(_on_body_entered)
	talk_area.body_exited.connect(_on_body_exited)

func _process(delta: float) -> void:
	pass

func ghosty_float() -> void:
	var speed = randf_range(1.0, 1.5)
	var displacement = randf_range(3, 4)
	var initial_y = position.y
	var up_y = position.y - displacement
	var down_y = position.y + displacement
	
	var tween := create_tween()
	tween.set_loops()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SINE)
	tween.tween_property(self, "position:y", up_y, speed)
	tween.tween_property(self, "position:y", down_y, speed * 1.0)
	tween.play()

func _on_body_entered(body) -> void:
	if body is Player:
		body.interactable = talk_area
		dialog_panel.visible = true

func _on_body_exited(body) -> void:
	if body is Player:
		body.interactable = null
		dialog_panel.visible = false
