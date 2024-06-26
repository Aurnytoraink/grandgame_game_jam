extends Node2D

@onready var tile_map_wa = $TileMapWA
@onready var tile_map_wn = $TileMapWN
@onready var tile_map_wu = $TileMapWU
@onready var player = $Player
@onready var audio_player = $AmbianceMusic


func _ready():
	$UI/JungleClock.show()
	$UI/ApoClock.hide()
	$UI/CityClock.hide()
	
	$UI/JungleFrontTimer.show()
	$UI/ApoFrontTimer.hide()
	$UI/CityFrontTimer.hide()
	
	$UI/JungleBackTimer.show()
	$UI/ApoBackTimer.hide()
	$UI/CityBackTimer.hide()
	

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
		$UI/ApoFrontTimer.show()
		$UI/JungleFrontTimer.hide()
		$UI/CityFrontTimer.hide()
		
		$UI/ApoBackTimer.show()
		$UI/JungleBackTimer.hide()
		$UI/CityBackTimer.hide()
		
		$UI/ApoClock.show()
		$UI/JungleClock.hide()
		$UI/CityClock.hide()
		tile_map_wa.set("layer_0/enabled", true)
		tile_map_wa.set("layer_1/enabled", true)
		tile_map_wn.set("layer_0/enabled", false)
		tile_map_wn.set("layer_1/enabled", false)
		tile_map_wu.set("layer_0/enabled", false)
		tile_map_wu.set("layer_1/enabled", false)
		play_sound(load("res://musics/ambiance_apocalypse.ogg"))
		
	if Input.is_action_just_pressed("switch_nature"):
		$UI/JungleFrontTimer.show()
		$UI/ApoFrontTimer.hide()
		$UI/CityFrontTimer.hide()
		
		$UI/JungleBackTimer.show()
		$UI/ApoBackTimer.hide()
		$UI/CityBackTimer.hide()
		
		$UI/JungleClock.show()
		$UI/ApoClock.hide()
		$UI/CityClock.hide()
	
		tile_map_wa.set("layer_0/enabled", false)
		tile_map_wa.set("layer_1/enabled", false)
		tile_map_wn.set("layer_0/enabled", true)
		tile_map_wn.set("layer_1/enabled", true)
		tile_map_wu.set("layer_0/enabled", false)
		tile_map_wu.set("layer_1/enabled", false)
		play_sound(load("res://musics/forest.ogg"))
		
	if Input.is_action_just_pressed("switch_urbain"):
		$UI/CityFrontTimer.show()
		$UI/ApoFrontTimer.hide()
		$UI/JungleFrontTimer.hide()
		
		$UI/CityBackTimer.show()
		$UI/ApoBackTimer.hide()
		$UI/JungleBackTimer.hide()
		
		$UI/CityClock.show()
		$UI/JungleClock.hide()
		$UI/ApoClock.hide()
		
	
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
