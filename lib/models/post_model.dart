enum PostType { audio, image, video, reel }

class PostModel {
  final String id;
  final String userId;
  final PostType type;
  final String? songId;
  final String? videoUrl;
  final String? thumbnailUrl;
  final String? imageUrl;
  final String title;
  final String description;
  final List<String> hashtags;
  final int likeCount;
  final int commentCount;
  final int viewCount;
  final bool downloadEnabled;
  final DateTime createdAt;

  PostModel({
    required this.id,
    required this.userId,
    required this.type,
    this.songId,
    this.videoUrl,
    this.thumbnailUrl,
    this.imageUrl,
    required this.title,
    required this.description,
    this.hashtags = const [],
    this.likeCount = 0,
    this.commentCount = 0,
    this.viewCount = 0,
    this.downloadEnabled = false,
    required this.createdAt,
  });

  factory PostModel.fromFirestore(Map<String, dynamic> d, String id) => PostModel(
    id: id,
    userId: d['userId'],
    type: PostType.values.firstWhere((e) => e.name == d['type'], orElse: () => PostType.audio),
    songId: d['songId'],
    videoUrl: d['videoUrl'],
    thumbnailUrl: d['thumbnailUrl'],
    imageUrl: d['imageUrl'],
    title: d['title']?? '',
    description: d['description']?? '',
    hashtags: List<String>.from(d['hashtags']?? []),
    likeCount: d['likeCount']?? 0,
    commentCount: d['commentCount']?? 0,
    viewCount: d['viewCount']?? 0,
    downloadEnabled: d['downloadEnabled']?? false,
    createdAt: DateTime.parse(d['createdAt']),
  );
}
