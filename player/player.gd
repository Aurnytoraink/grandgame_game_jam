extends CharacterBody2D


@export var SPEED = 300.0
@export var GRAVITY = 30
@export var JUMP_VELOCITY = 400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.



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
	

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var horizontal_direction=Input.get_axis("move_left","move_right")
	$Camera2D.set_drag_horizontal_offset(horizontal_direction * 2)
	if horizontal_direction:
		velocity.x = horizontal_direction * SPEED
		$AnimationPlayer.play("walk")
		$Sprite2D.flip_h = true if (horizontal_direction == -1) else false
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		$AnimationPlayer.stop()

	move_and_slide()
