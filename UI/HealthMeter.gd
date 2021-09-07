extends Control
 
var PlayerStats = ResourceLoader0.PlayerStats

onready var full = $Full

func _ready():
	PlayerStats.connect("player_health_changed", self, "_on_player_health_changed")

func _on_player_health_changed(value):
	full.rect_size.x = value * 10 + 1 #5 porque o sprite de health tem 5 pixels no eixo x. entao cada value a mais, deve ser multiplicado pela quantidade de pixels no eixo desejado. PLUS 1 porque a margem didreita do sprite tem q TILE com o prox TILE. entao plus 1 pra encaixar
