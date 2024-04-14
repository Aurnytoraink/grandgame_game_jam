extends Node2D

@onready var tile_map_wa = $TileMapWA
@onready var tile_map_wn = $TileMapWN
@onready var tile_map_wu = $TileMapWU
@onready var player = $Player


func _ready():
	$Timer.start()

func _process(_delta):
	switch_scene()
	$CanvasLayer/TimerLabel.text="%d:%02d" % [floor($Timer.time_left / 60), int($Timer.time_left) % 60]
	if Input.is_action_just_pressed("reset"):
		reset_scene()

func reset_scene():
	player.position = $Spawner.position
	player.is_dead = false
	$Timer.start()
	#relancer l'animation player.set()

func switch_scene():
	if Input.is_action_just_pressed("switch_apocalypse"):
		tile_map_wa.set("layer_0/enabled", true)
		tile_map_wa.set("layer_1/enabled", true)
		tile_map_wn.set("layer_0/enabled", false)
		tile_map_wn.set("layer_1/enabled", false)
		tile_map_wu.set("layer_0/enabled", false)
		tile_map_wu.set("layer_1/enabled", false)
	if Input.is_action_just_pressed("switch_nature"):
		tile_map_wa.set("layer_0/enabled", false)
		tile_map_wa.set("layer_1/enabled", false)
		tile_map_wn.set("layer_0/enabled", true)
		tile_map_wn.set("layer_1/enabled", true)
		tile_map_wu.set("layer_0/enabled", false)
		tile_map_wu.set("layer_1/enabled", false)
	if Input.is_action_just_pressed("switch_urbain"):
		tile_map_wa.set("layer_0/enabled", false)
		tile_map_wa.set("layer_1/enabled", false)
		tile_map_wn.set("layer_0/enabled", false)
		tile_map_wn.set("layer_1/enabled", false)
		tile_map_wu.set("layer_0/enabled", true)
		tile_map_wu.set("layer_1/enabled", true)
