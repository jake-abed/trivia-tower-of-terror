extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(_body_entered)
	body_exited.connect(_body_exited)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _body_entered(body) -> void:
	if body is Player:
		body.interactable = self
		%TowerSign.visible = true

func _body_exited(body) -> void:
	if body is Player:
		body.interactable = null
		%TowerSign.visible = false
