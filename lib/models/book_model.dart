import 'category_model.dart';

class BookModel {
  final int id;
  final String title;
  final String author;
  final String publisher;
  final int year;
  final int category
   
  final String description;
  final String coverUrl;
  final int categoryId;
  final CategoryModel? category;

  BookModel({
    required this.id,
    required this.title,
    required this.author,
    required this.description,
    required this.coverUrl,
    required this.categoryId,
    this.category,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      id: json['id'],
      title: json['title'] ?? '',
      author: json['author'] ?? '',
      publisher: json['publisher'] ?? '',
      year: json ['year'] ?? 0,
      category: json ['category'] != null
      description: json['description'] ?? '',
      stock: json['stock'] ?? 0,
      borrowed_count: json['borrowed_count'] ?? 0,
      created_at: json ['created_at'] != null
      updated_at: json ['updated_at'] != null
      quantity: json['quantity'] ?? 0,
      published_year: json['published_year'] ?? 0,

    
     
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'author': author,
        'description': description,
        'cover_url': coverUrl,
        'category_id': categoryId,
        'category': category?.toJson(),
      };

  // Getter untuk nama kategori
  String get categoryName => category?.name ?? '-';
}
