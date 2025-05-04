extends AudioStreamPlayer2D

var short_honk = load("res://assets/audio/effects/GooseHonk.mp3")
var long_honk = load("res://assets/audio/effects/GooseHonkLong.wav")

var curr_track = 0
var in_levels = true

func _play_music(music: AudioStream, volume = 0.0):
	if stream == music:
		return
	
	stream = music
	volume_db = volume
	play()
	
func play_long_honk():
	_play_music(long_honk)
	
func play_short_honk():
	in_levels = false
	_play_music(short_honk)
	
	
