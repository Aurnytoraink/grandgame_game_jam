extends Node
class_name DashComponent

var Player: CharacterBody2D
var MoveComponent: Node
var InputDirection : Vector2 = Vector2.ZERO

var CanDash: bool = true
var IsDashing: bool = false

@export var DashMult: float = 3.5
@export var Duration: float = 0.075  #valeur en secondes
@export var Cooldown: float = 0.5	#idem ici

var DurationTimer: Timer
var CooldownTimer: Timer

func set_timer(timer_name, duration) -> void:
	timer_name.one_shot = true
	timer_name.autostart = false
	timer_name.wait_time = duration
	add_child(timer_name)

func dash() -> void:
	Player.velocity = Player.velocity.lerp(InputDirection * MoveComponent.MoveSpeed * DashMult, 0.25)
	Player.move_and_slide()

func stop_dashing() -> void:
	IsDashing = false
	CooldownTimer.start()
	Player.velocity = Vector2.ZERO

func cooldown_done() -> void:
	CanDash = true

func _ready() -> void: 
	Player = get_parent()
	MoveComponent = get_node("../MovementComponent")
	
	# Timer du dash
	DurationTimer = Timer.new()
	set_timer(DurationTimer, Duration)
	DurationTimer.timeout.connect(stop_dashing)
	
	# Timer du cooldown
	CooldownTimer = Timer.new()
	set_timer(CooldownTimer, Cooldown)
	CooldownTimer.timeout.connect(cooldown_done)

func _process(delta: float) -> void:
	match IsDashing:
		true:
			dash()
		false:
			if Input.is_action_just_pressed('dash') and CanDash:
				InputDirection = Input.get_vector('move_left', 'move_right', 'move_up', 'move_down').normalized()

				#MovementComponent perd le controle du personnage
				MoveComponent.set_process_mode(4)
				
				#initier le dash
				DurationTimer.start()
				IsDashing = true
				CanDash = false
				dash()
			else:
				#MovementComponent reprend la main
				MoveComponent.set_process_mode(0)
