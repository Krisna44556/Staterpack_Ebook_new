import 'category_model.dart';

class BookModel {
  final int id;
  final String title;
  final String author;
  final String publisher;
  final int year;
  final int stock;
  final int borrowedCount;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String description;
  final String coverUrl;
  final int categoryId;
  final CategoryModel? category;

  BookModel({
    required this.id,
    required this.title,
    required this.author,
    required this.publisher,
    required this.year,
    required this.stock,
    required this.borrowedCount,
    required this.createdAt,
    required this.updatedAt,
    required this.description,
    required this.coverUrl,
    required this.categoryId,
    this.category,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      author: json['author'] ?? '',
      publisher: json['publisher'] ?? '',
      year: json['year'] ?? 0,
      stock: json['stock'] ?? 0,
      borrowedCount: json['borrowed_count'] ?? 0,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,
      description: json['description'] ?? '',
      coverUrl: json['cover_url'] ?? '',
      categoryId: json['category_id'] ?? 0,
      category: json['category'] != null
          ? CategoryModel.fromJson(json['category'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'author': author,
        'publisher': publisher,
        'year': year,
        'stock': stock,
        'borrowed_count': borrowedCount,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'description': description,
        'cover_url': coverUrl,
        'category_id': categoryId,
        'category': category?.toJson(),
      };

  // Getter untuk nama kategori
  String get categoryName => category?.name ?? '-';

  // Getter untuk ketersediaan buku
  bool get isAvailable => stock > borrowedCount;
}
