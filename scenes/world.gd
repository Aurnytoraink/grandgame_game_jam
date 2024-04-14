extends Node2D

@onready var tile_map_wa = $TileMapWA
@onready var tile_map_wn = $TileMapWN
@onready var tile_map_wu = $TileMapWU

func _process(delta):
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
