extends CharacterBody2D

signal death_animation_ended

@export var JUMP_VELOCITY = 1000
@export var SPEED = 300
@export var RUN_SPEED = 300 * 2
@export var DASH_SPEED = 300 * 3

@onready var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var state_machine = $AnimationTree.get("parameters/playback")
@onready var audio_streamer = $AudioStreamPlayer2D

@onready var switch_time_sfx = preload("res://player/switch_time_sfx.wav")
@onready var die_sound = preload("res://player/MetalSlash1.wav")
@onready var jump_sound = preload("res://player/quick_jump.wav")

var rng = RandomNumberGenerator.new()

enum {
	MOVE,
	RUN,
	DASH
}

var is_dead = false
var can_dash = true
var state = MOVE

func _process(delta):
	$Label2.text = "Mort(e)" if is_dead else "Vivant(e)"
	var etat_anim = state_machine.get_current_node()
	$Label.text = etat_anim
	$AnimationTree.set("parameters/Move/blend_position", velocity.x)
	$AnimationTree.set("parameters/conditions/is_falling", velocity.y>0)
	$AnimationTree.set("parameters/conditions/on_ground", is_on_floor())
	$AnimationTree.set("parameters/conditions/reach_max_jump", 0.1 > velocity.y or -0.1 < velocity.y )
	$AnimationTree.set("parameters/conditions/is_switching", Input.is_action_just_pressed("switch_apocalypse") or Input.is_action_just_pressed("switch_nature") or Input.is_action_just_pressed("switch_urbain"))


func _physics_process(delta):
	#$"../CanvasLayer/Label".text="%d:%02d" % [floor($"../Timer".time_left / 60), int($"../Timer".time_left) % 60]
	$Camera2D.set_drag_horizontal_offset(Input.get_axis("move_left","move_right") * 2)

	match state:
		MOVE:
			walk_state()
		RUN:
			run_state()
		DASH:
			dash_state(Input.get_axis("move_left","move_right"))

	#Gravity
	if not is_on_floor():
		velocity.y += gravity * delta

	# JUMP
	if Input.is_action_just_pressed("jump") and is_on_floor():
		var random_number = rng.randf_range(1, 30)
		if random_number==1:
			var random_world = rng.randf_range(1, 2)
			if random_world == 1:
				pass
			elif random_world == 2 :
				pass
		
		velocity.y = -JUMP_VELOCITY
		play_sound(jump_sound)
		state_machine.travel("jump_up")

	velocity.y = clamp(velocity.y, -1000, 1000)

	if Input.is_action_just_pressed("dash") and Input.get_axis("move_left","move_right") != 0 and can_dash == true:
		can_dash = false
		state_machine.travel("dash")
		state = DASH

	if Input.is_action_pressed("run") and state != DASH:
		state = RUN

	if Input.is_action_just_released("run"):
		state = MOVE

	if Input.is_action_just_pressed("switch_apocalypse") or Input.is_action_just_pressed("switch_nature") or Input.is_action_just_pressed("switch_urbain"):
		play_sound(switch_time_sfx)
		
	move_and_slide()
	update_direction()

func update_direction():
	if velocity.x < 0:
		$Sprite2D.flip_h = true
	elif velocity.x > 0:
		$Sprite2D.flip_h = false

func walk_state():
	velocity.x = Input.get_axis("move_left","move_right") * SPEED

func run_state():
	velocity.x = Input.get_axis("move_left","move_right") * RUN_SPEED

func dash_state(direction):
	velocity.x = direction * DASH_SPEED

func die(_x):
	is_dead = true
	play_sound(die_sound)
	state_machine.travel("death")
	#queue_free()

func on_dash_finished():
	state = MOVE

func play_sound(sound):
	if audio_streamer.is_playing():
		audio_streamer.stop()
	audio_streamer.stream = sound
	audio_streamer.play()

func _on_dash_count_down_timeout():
	can_dash = true

func _on_suffocation_detection_body_entered(body):
	print(body)
	print("le personnage suffoque")


func _on_animation_tree_animation_finished(anim_name):
	if anim_name == "death":
		emit_signal("death_animation_ended")
