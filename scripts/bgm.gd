extends AudioStreamPlayer

const lvl_music_1 = preload("res://assets/audio/music/29 Sunrise & Onett Theme.mp3")
const lvl_music_2 = preload("res://assets/audio/music/99 Threed, Free at Last.mp3")
const boss_music = preload("res://assets/audio/music/100 Get on the Bus.mp3")

var music_tracks = [lvl_music_1, lvl_music_2]
var curr_track = 0
var in_levels = true

func _play_music(music: AudioStream, volume = 0.0):
	if stream == music:
		return
	
	stream = music
	volume_db = volume
	play()
	
func play_music_level():
	_play_music(lvl_music_1)
	
func play_boss_music():
	in_levels = false
	_play_music(boss_music)
	

# _on_finished
# This function will cycle through music_tracks if currently in a level
func _on_finished() -> void:
	if in_levels:
		if (curr_track == music_tracks.size() - 1):
			curr_track = 0
		_play_music(music_tracks[curr_track + 1])
	
	
