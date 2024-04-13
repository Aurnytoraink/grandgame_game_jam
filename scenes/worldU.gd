extends Node2D

# Référence au singleton de sauvegarde de position du joueur


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Si le joueur appuie sur la touche pour changer vers la scène "worldN"
	if Input.is_action_just_pressed("action_nature"):
	
		get_tree().change_scene_to_file("res://scenes/worldN.tscn")
	
	if Input.is_action_just_pressed("action_apo"):
	
		get_tree().change_scene_to_file("res://scenes/worldA.tscn")
		
