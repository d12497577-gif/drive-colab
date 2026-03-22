class MovieModel {
  final int id;
  final String title;
  final String description;
  final String? releaseYear;
  final String poster;
  final String videoUrl;
  final int? categoryId;
  final String? categoryName;

  MovieModel({
    required this.id,
    required this.title,
    required this.description,
    this.releaseYear,
    required this.poster,
    required this.videoUrl,
    this.categoryId,
    this.categoryName,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'] is int ? json['id'] : int.tryParse('${json['id']}') ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      releaseYear: json['release_year'] != null ? '${json['release_year']}' : null,
      poster: json['poster'] ?? '',
      videoUrl: json['video_url'] ?? '',
      categoryId: json['category_id'] != null ? int.tryParse('${json['category_id']}') : null,
      categoryName: json['category_name'],
    );
  }
}
