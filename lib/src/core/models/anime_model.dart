import 'episode_model.dart';

class AnimeModel {
  final int id;
  final String title;
  final String description;
  final String? releaseYear;
  final String poster;
  final int? categoryId;
  final String? categoryName;
  final String status;
  final int episodeCount;
  final List<EpisodeModel> episodes;

  AnimeModel({
    required this.id,
    required this.title,
    required this.description,
    this.releaseYear,
    required this.poster,
    this.categoryId,
    this.categoryName,
    required this.status,
    required this.episodeCount,
    required this.episodes,
  });

  factory AnimeModel.fromJson(Map<String, dynamic> json) {
    final rawEpisodes = json['anime_episodes'];
    final episodes = <EpisodeModel>[];

    if (rawEpisodes is List) {
      episodes.addAll(rawEpisodes
          .whereType<Map<String, dynamic>>()
          .map((e) => EpisodeModel.fromJson(e)));
    }

    return AnimeModel(
      id: json['id'] is int ? json['id'] : int.tryParse('${json['id']}') ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      releaseYear: json['release_year'] != null ? '${json['release_year']}' : null,
      poster: json['poster'] ?? '',
      categoryId: json['category_id'] != null ? int.tryParse('${json['category_id']}') : null,
      categoryName: json['category_name'],
      status: json['status'] ?? '',
      episodeCount: json['episode_count'] is int
          ? json['episode_count']
          : int.tryParse('${json['episode_count']}') ?? 0,
      episodes: episodes,
    );
  }
}
