extends Node
class_name GrapplingComponent

var Player: CharacterBody2D
var Hook: CharacterBody2D
var Line: Line2D

@export var GrabLength: float = 250
@export var GrabSpeed: float = 1250
var GrabVel: Vector2 = Vector2.ZERO
var PullVel: Vector2 = Vector2.ZERO
@export var PullStrenght: float = 75
var InputDirection: Vector2 = Vector2.ZERO

var Flying: bool = false
var Hooked: bool = false

func reset_hook() -> void:
	Flying = false
	Hooked = false
	Hook.velocity = Vector2.ZERO
	Hook.position = Player.position

func _ready() -> void:
	Player = get_owner()
	Hook = $CharacterBody2D
	Line = $Line2D

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_released('grab'):
		reset_hook()

func _physics_process(delta: float) -> void:
	match Flying:
		false:
			if Input.is_action_just_pressed('grab'):
				InputDirection = Input.get_vector('aim_left', 'aim_right', 'aim_up', 'aim_down').normalized()
				if InputDirection == Vector2.ZERO:
					InputDirection = Vector2.RIGHT
				Hook.position = Player.position
				GrabVel = InputDirection * GrabSpeed
				Hook.velocity = GrabVel
				Flying = true
		true:
			Hook.move_and_slide()
			if Hook.velocity.length() < GrabVel.length():
				Hook.velocity = Vector2.ZERO
				Flying = false
				Hooked = true
			if Hook.position.distance_to(Player.position) > GrabLength:
				reset_hook()
	Line.visible = Flying or Hooked

	Line.set_point_position(0, Line.to_local(Player.position))
	Line.set_point_position(1, Line.to_local(Hook.position))

	# Hook physics
	if Hooked:
		# `to_local($Chain.tip).normalized()` is the direction that the chain is pulling
		PullVel = (Hook.position - Player.position).normalized() * PullStrenght
		if PullVel.y > 0:
			# Pulling down isn't as strong
			PullVel.y *= 0.55
		else:
			# Pulling up is stronger
			PullVel.y *= 1.65
		if sign(PullVel.x) != sign(Player.velocity.x):
			# if we are trying to walk in a different
			# direction than the chain is pulling
			# reduce its pull
			PullVel.x *= 0.7
	else:
		# Not hooked -> no chain velocity
		PullVel = Vector2.ZERO
	Player.velocity += PullVel
