import 'review_model.dart';

class BookModel {
  final int id;
  final String title;
  final String author;
  final String? publisher;
  final int? publishedYear;
  final String description;
  final String imageUrl;
  final int? quantity;
  final int? borrowedCount;
  final String? category; // Nama kategori
  final double? rating;
  final List<ReviewModel>? reviews;

  BookModel({
    required this.id,
    required this.title,
    required this.author,
    this.publisher,
    this.publishedYear,
    required this.description,
    required this.imageUrl,
    this.quantity,
    this.borrowedCount,
    this.category,
    this.rating,
    this.reviews,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      id: json['id'],
      title: json['title'] ?? '',
      author: json['author'] ?? '',
      publisher: json['publisher'],
      publishedYear: json['published_year'],
      description: json['description'] ?? '',
      imageUrl: json['image_url'] ?? '',
      quantity: json['quantity'],
      borrowedCount: json['borrowed_count'],
      category: json['category'], // langsung nama kategori (string)
      rating: (json['rating'] as num?)?.toDouble(),
      reviews: (json['reviews'] as List<dynamic>?)
          ?.map((e) => ReviewModel.fromJson(e))
          .toList(),
    );
  }

  get coverUrl => null;

  get categoryName => null;

  get isAvailable => null;

  get year => null;

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'author': author,
        'publisher': publisher,
        'published_year': publishedYear,
        'description': description,
        'image_url': imageUrl,
        'quantity': quantity,
        'borrowed_count': borrowedCount,
        'category': category,
        'rating': rating,
        'reviews': reviews?.map((e) => e.toJson()).toList(),
      };
}