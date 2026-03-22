class ChannelModel {
  final int id;
  final String name;
  final String logo;
  final String m3uLink;
  final int? categoryId;
  final String? categoryName;
  final String status;

  ChannelModel({
    required this.id,
    required this.name,
    required this.logo,
    required this.m3uLink,
    this.categoryId,
    this.categoryName,
    required this.status,
  });

  factory ChannelModel.fromJson(Map<String, dynamic> json) {
    return ChannelModel(
      id: json['id'] is int ? json['id'] : int.tryParse('${json['id']}') ?? 0,
      name: json['name'] ?? '',
      logo: json['logo'] ?? '',
      m3uLink: json['m3u_link'] ?? '',
      categoryId: json['category_id'] != null ? int.tryParse('${json['category_id']}') : null,
      categoryName: json['category_name'],
      status: json['status'] ?? '',
    );
  }
}
