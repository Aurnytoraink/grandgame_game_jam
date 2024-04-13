extends CharacterBody2D


@export var SPEED = 300.0
@export var GRAVITY = 30
@export var JUMP_VELOCITY = 400.0

@onready var state_machine = $AnimationTree.get("parameters/playback")

# Get the gravity from the project settings to be synced with RigidBody nodes.

var can_dash = false

func _process(delta):
	var etat_anim = state_machine.get_current_node()
	$Label.text = etat_anim
	$AnimationTree.set("parameters/Move/blend_position", velocity.x)
	$AnimationTree.set("parameters/conditions/is_falling", velocity.y>0)
	$AnimationTree.set("parameters/conditions/on_ground", is_on_floor())
	$AnimationTree.set("parameters/conditions/reach_max_jump", 0.1 > velocity.y or -0.1 < velocity.y )

func _physics_process(delta):
	#Gravity
	if not is_on_floor():
		velocity.y += GRAVITY

		#$Camera2D.set_position_smoothing_speed(5)
		#$Camera2D.set_position_smoothing_speed(2)
	if velocity.y>1000:
		velocity.y=1000


	# JUMP
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -JUMP_VELOCITY
		state_machine.travel("jump_up")

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
		
	$Camera2D.set_drag_horizontal_offset(Input.get_axis("move_left","move_right") * 2)
	velocity.x = Input.get_axis("move_left","move_right") * SPEED
		
	if Input.is_action_pressed("run"):
		velocity.x = Input.get_axis("move_left","move_right")  * SPEED * 2
		

	move_and_slide()
	update_direction()
	
	#print(velocity.y)
	

func update_direction():
	if velocity.x < 0:
		$Sprite2D.flip_h = true
	elif velocity.x > 0:
		$Sprite2D.flip_h = false
		
	
	
