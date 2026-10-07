import 'package:equatable/equatable.dart';

class SongModel extends Equatable {
  final String id;
  final String title;
  final String artist;
  final String coverUrl;
  final String audioUrl;
  final int duration; // seconds
  final String genre;
  final String description;
  final DateTime createdAt;
  final int playCount;
  final int likeCount;
  final bool downloadEnabled;
  final bool isFeatured;

  const SongModel({
    required this.id,
    required this.title,
    required this.artist,
    required this.coverUrl,
    required this.audioUrl,
    required this.duration,
    required this.genre,
    required this.description,
    required this.createdAt,
    this.playCount = 0,
    this.likeCount = 0,
    this.downloadEnabled = false,
    this.isFeatured = false,
  });

  factory SongModel.fromFirestore(Map<String, dynamic> data, String id) => SongModel(
    id: id,
    title: data['title'],
    artist: data['artist'],
    coverUrl: data['coverUrl'],
    audioUrl: data['audioUrl'],
    duration: data['duration']?? 0,
    genre: data['genre']?? 'Pop',
    description: data['description']?? '',
    createdAt: DateTime.parse(data['createdAt']),
    playCount: data['playCount']?? 0,
    likeCount: data['likeCount']?? 0,
    downloadEnabled: data['downloadEnabled']?? false,
    isFeatured: data['isFeatured']?? false,
  );

  Map<String, dynamic> toMap() => {
    'title': title,
    'artist': artist,
    'coverUrl': coverUrl,
    'audioUrl': audioUrl,
    'duration': duration,
    'genre': genre,
    'description': description,
    'createdAt': createdAt.toIso8601String(),
    'playCount': playCount,
    'likeCount': likeCount,
    'downloadEnabled': downloadEnabled,
    'isFeatured': isFeatured,
  };

  @override
  List<Object?> get props => [id];
}
