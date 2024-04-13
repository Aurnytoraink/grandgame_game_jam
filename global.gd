extends Node

# Déclaration des variables pour stocker la position du joueur
var player_position_x = 0
var player_position_y = 0

# Fonction pour sauvegarder la position du joueur
func save_player_position(player):
	player_position_x = player.global_position.x
	player_position_y = player.global_position.y

# Fonction pour restaurer la position du joueur
func restore_player_position(player):
	player.global_position.x = player_position_x
	player.global_position.y = player_position_y
