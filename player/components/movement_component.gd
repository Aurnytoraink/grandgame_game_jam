extends Node
class_name MovementComponent

var Player: CharacterBody2D
@export var Gravity: float = 750.0
@export var MoveSpeed: float = 800.0
@export var JumpSpeed: float = -850.0
var InputDirection: Vector2 = Vector2.ZERO

func _ready() -> void:
	Player = get_parent()

func _physics_process(delta: float) -> void:
	var AirTime: float = 0.0
	InputDirection = Input.get_vector('move_left', 'move_right', 'move_up', 'move_down').normalized()

	match Player.is_on_floor():
		true:
			AirTime = 0.0
		false:
			AirTime += delta

	Player.velocity.y += (Gravity + Gravity * AirTime * 150) * delta

	Player.velocity.x = InputDirection.x * MoveSpeed

	if Input.is_action_just_pressed('jump') and Player.is_on_floor():
		Player.velocity.y = JumpSpeed
	Player.move_and_slide()
