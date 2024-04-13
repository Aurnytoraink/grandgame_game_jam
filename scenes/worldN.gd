extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("action_urbain"):
		
		get_tree().change_scene_to_file("res://scenes/worldU.tscn")
	if Input.is_action_just_pressed("action_apo"):
		get_tree().change_scene_to_file("res://scenes/worldA.tscn")
