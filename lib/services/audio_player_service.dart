import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import '../models/song_model.dart';

class AudioPlayerService {
  final AudioPlayer _player = AudioPlayer();

  AudioPlayer get player => _player;

  Future<void> init() async {
    await JustAudioBackground.init(
      androidNotificationChannelId: 'com.turrini.turrinimusic.channel.audio',
      androidNotificationChannelName: 'TURRINIMUSIC Playback',
      androidNotificationOngoing: true,
    );
  }

  Future<void> playSong(SongModel song) async {
    final source = AudioSource.uri(
      Uri.parse(song.audioUrl),
      tag: MediaItem(
        id: song.id,
        title: song.title,
        artist: song.artist,
        artUri: Uri.parse(song.coverUrl),
        duration: Duration(seconds: song.duration),
      ),
    );
    await _player.setAudioSource(source);
    await _player.play();
  }

  Future<void> play() => _player.play();
  Future<void> pause() => _player.pause();
  Future<void> seek(Duration d) => _player.seek(d);
  Future<void> next() => _player.seekToNext();
  Future<void> previous() => _player.seekToPrevious();
  Future<void> setShuffle(bool v) => _player.setShuffleModeEnabled(v);
  Future<void> setLoop(LoopMode mode) => _player.setLoopMode(mode);

  void dispose() => _player.dispose();
}
