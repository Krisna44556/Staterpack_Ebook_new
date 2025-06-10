class ReviewModel {
  final int id;
  final String user;
  final double rating;
  final String comment;
  final String createdAt;

  ReviewModel({
    required this.id,
    required this.user,
    required this.rating,
    required this.comment,
    required this.createdAt,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'],
      user: json['user'] ?? 'Anonymous',
      rating: (json['rating'] as num).toDouble(),
      comment: json['comment'] ?? '',
      createdAt: json['created_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'user': user,
        'rating': rating,
        'comment': comment,
        'created_at': createdAt,
      };
}
