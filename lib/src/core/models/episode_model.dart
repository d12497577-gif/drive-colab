class EpisodeModel {
  final int id;
  final int animeId;
  final int episodeNumber;
  final String title;
  final String videoUrl;

  EpisodeModel({
    required this.id,
    required this.animeId,
    required this.episodeNumber,
    required this.title,
    required this.videoUrl,
  });

  factory EpisodeModel.fromJson(Map<String, dynamic> json) {
    return EpisodeModel(
      id: json['id'] is int ? json['id'] : int.tryParse('${json['id']}') ?? 0,
      animeId: json['anime_id'] is int ? json['anime_id'] : int.tryParse('${json['anime_id']}') ?? 0,
      episodeNumber: json['episode_number'] is int
          ? json['episode_number']
          : int.tryParse('${json['episode_number']}') ?? 0,
      title: json['title'] ?? '',
      videoUrl: json['video_url'] ?? '',
    );
  }
}
