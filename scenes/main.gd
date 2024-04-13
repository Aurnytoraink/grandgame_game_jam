extends Node2D

var apocalypse_scene = preload("res://scenes/levels/worldA.tscn")
var nature_scene = preload("res://scenes/levels/worldN.tscn")
var urbain_scene = preload("res://scenes/levels/worldU.tscn")

func _ready():
	add_child(nature_scene.instantiate())

func _process(delta):
	if Input.is_action_just_pressed("action_apo"):
		add_child(apocalypse_scene.instantiate())
		get_child(-2).queue_free()
		
	if Input.is_action_just_pressed("action_nature"):
		add_child(nature_scene.instantiate())
		get_child(-2).queue_free()
		
	if Input.is_action_just_pressed("action_urbain"):
		add_child(urbain_scene.instantiate())
		get_child(-2).queue_free()
