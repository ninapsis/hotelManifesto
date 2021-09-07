extends Node

var sounds_path = "res://Music and Sounds/"

var sounds = {
	"Bullet" : load(sounds_path + "Bullet.wav"),
	"Click" : load(sounds_path + "click2.wav"),
	"EnemyDie" : load(sounds_path + "EnemyDie.wav"),
	"Explosion" : load(sounds_path + "Explosion.wav"),
	"Hurt" : load(sounds_path + "Hurt.wav"),
	"Jump" : load(sounds_path + "Jump.wav"),
	"Pause" : load(sounds_path + "Pause.wav"),
	"Powerup" : load(sounds_path + "Powerup.wav"),
	"Step" : load(sounds_path + "Step.wav"),
	"Unpause" : load(sounds_path + "Unpause.wav"),
	"Monster" : load(sounds_path + "Monster.wav"),
	"Dong" : load(sounds_path + "dong.wav"),
	"Huh_girl" : load(sounds_path + "aura.wav"),
	"Huhuh" : load(sounds_path + "huhuh.wav"),
	"Herp" : load(sounds_path + "herp.wav"),
	"Vuash" : load(sounds_path + "vuash.wav"),
	"Boy" : load(sounds_path + "boy.wav"),
	"Baby" : load(sounds_path + "baby.wav"),
	"Baby2" : load(sounds_path + "baby2.wav"),
	"Miau" : load(sounds_path + "gato.wav"),
	"Bub" : load(sounds_path + "bub.wav"),
	"Sino" : load(sounds_path + "SaveBell.wav"),
	"Locked": load(sounds_path + "locked.wav"),
	"Leaves":load(sounds_path + "leaves.wav"),
	"Roar" :load(sounds_path + "roar.wav"),
	"Typewriter":load(sounds_path + "typewriter.wav"),
	"SceneChange": load(sounds_path + "scenechange.wav"),
	"internet": load(sounds_path + "internet.wav"),
	"mainmenuhum": load(sounds_path + "humming_new_02.ogg"),
	"girl-sad": load(sounds_path + "girl-sad.wav")
}
func _ready():
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), 0)

onready var sound_players = get_children()

func play(sound_string, pitch_scale = 1, volume_db = 0):
	for soundPlayer in sound_players:
		if not soundPlayer.playing:
			soundPlayer.pitch_scale = pitch_scale
			soundPlayer.volume_db = volume_db
			soundPlayer.stream = sounds[sound_string]
			soundPlayer.play()
			return
	print("mto audio parece")
