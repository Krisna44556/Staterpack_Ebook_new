class ReviewModel {
  final String userId;
  final String comment;
  final double rating;

  ReviewModel({
    required this.userId,
    required this.comment,
    required this.rating,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      userId: json['userId'],
      comment: json['comment'],
      rating: (json['rating'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'comment': comment,
      'rating': rating,
    };
  }
}
