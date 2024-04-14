extends Node2D

@onready var tile_map_wa = $TileMapWA
@onready var tile_map_wn = $TileMapWN
@onready var tile_map_wu = $TileMapWU
@onready var player = $Player
@onready var audio_player = $AmbianceMusic
@onready var _pause_menu := $PauseMenu


func _ready():
	tile_map_wa.set("layer_0/enabled", false)
	tile_map_wa.set("layer_1/enabled", false)
	tile_map_wn.set("layer_0/enabled", true)
	tile_map_wn.set("layer_1/enabled", true)
	tile_map_wu.set("layer_0/enabled", false)
	tile_map_wu.set("layer_1/enabled", false)
	
	play_sound(load("res://musics/forest.ogg"))
	$Timer.start()

func _process(_delta):
	switch_scene()
	$UI/TimerLabel.text="%d:%02d" % [floor($Timer.time_left / 60), int($Timer.time_left) % 60]
	if Input.is_action_just_pressed("reset"):
		reset_scene()
	#menu pause
	if Input.is_action_pressed("pause_menu"):
		var tree := get_tree()
		tree.paused = not tree.paused
		if tree.paused:
			_pause_menu.open()
		else:
			_pause_menu.close()
		#get_tree().root.set_input_as_handled()

func reset_scene():
	play_sound(load("res://musics/forest.ogg"))
	player.position = $Spawner.position
	player.is_dead = false
	player.state_machine.travel("Start")
	$Timer.start()
	#relancer l'animation player.set()
	
	#Remet nature
	tile_map_wa.set("layer_0/enabled", false)
	tile_map_wa.set("layer_1/enabled", false)
	tile_map_wn.set("layer_0/enabled", true)
	tile_map_wn.set("layer_1/enabled", true)
	tile_map_wu.set("layer_0/enabled", false)
	tile_map_wu.set("layer_1/enabled", false)

func switch_scene():
	if Input.is_action_just_pressed("switch_apocalypse"):
		tile_map_wa.set("layer_0/enabled", true)
		tile_map_wa.set("layer_1/enabled", true)
		tile_map_wn.set("layer_0/enabled", false)
		tile_map_wn.set("layer_1/enabled", false)
		tile_map_wu.set("layer_0/enabled", false)
		tile_map_wu.set("layer_1/enabled", false)
		play_sound(load("res://musics/ambiance_apocalypse.ogg"))
		
	if Input.is_action_just_pressed("switch_nature"):
		tile_map_wa.set("layer_0/enabled", false)
		tile_map_wa.set("layer_1/enabled", false)
		tile_map_wn.set("layer_0/enabled", true)
		tile_map_wn.set("layer_1/enabled", true)
		tile_map_wu.set("layer_0/enabled", false)
		tile_map_wu.set("layer_1/enabled", false)
		play_sound(load("res://musics/forest.ogg"))
		
	if Input.is_action_just_pressed("switch_urbain"):
		tile_map_wa.set("layer_0/enabled", false)
		tile_map_wa.set("layer_1/enabled", false)
		tile_map_wn.set("layer_0/enabled", false)
		tile_map_wn.set("layer_1/enabled", false)
		tile_map_wu.set("layer_0/enabled", true)
		tile_map_wu.set("layer_1/enabled", true)
		play_sound(load("res://musics/urban.ogg"))

func play_sound(sound):
	if audio_player.is_playing():
		audio_player.stop()
	audio_player.stream = sound
	audio_player.play()

func _on_perso_touche_arrivee(body):
	print("victoire")
	player.get_node("Victoire").text = "Victoire"
