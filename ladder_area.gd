extends Area2D


func _ready() -> void:
	body_entered.connect(_body_entered)
	body_exited.connect(_body_exited)

func _process(delta: float) -> void:
	pass

func _body_entered(body) -> void:
	if body is Player:
		body.interactable = self
		%LadderPanel.visible = true

func _body_exited(body) -> void:
	if body is Player:
		body.interactable = null
		%LadderPanel.visible = false
