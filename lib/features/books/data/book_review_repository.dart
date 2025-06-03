import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../models/review_model.dart';

class BookReviewRepository {
  final String baseUrl = 'http://127.0.0.1:8000'; 

  Future<List<ReviewModel>> fetchReviews(int bookId) async {
    final response = await http.get(Uri.parse('$baseUrl/books/$bookId/reviews'));

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => ReviewModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to fetch reviews');
    }
  }

  Future<void> submitReview(int bookId, ReviewModel review) async {
    final response = await http.post(
      Uri.parse('$baseUrl/books/$bookId/reviews'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(review.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to submit review');
    }
  }
}
