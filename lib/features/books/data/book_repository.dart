import 'package:dio/dio.dart';
import '../../../core/constants/api_endpoints.dart';
import '../../../core/service/dio_client.dart';
import '../../../models/book_model.dart';

class BookRepository {
  final Dio dio;

  BookRepository({Dio? dio}) : dio = dio ?? DioClient.dio;

  Future<List<BookModel>> fetchPublicBooks() async {
    try {
      final response = await dio.get(ApiEndpoints.publicBooks);
      final List data = response.data['data'] as List;
      return data.map((json) => BookModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Gagal mengambil daftar buku publik: $e');
    }
  }

  Future<List<BookModel>> fetchTopBooks() async {
    try {
      final response = await dio.get(ApiEndpoints.topBooks);
      final List data = response.data['data'] as List;
      return data.map((json) => BookModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Gagal mengambil buku terpopuler: $e');
    }
  }

  Future<List<BookModel>> fetchBooksByCategory(int categoryId) async {
    try {
      final response = await dio.get('${ApiEndpoints.bookByCategory}/$categoryId');
      final List data = response.data['data'] as List;
      return data.map((json) => BookModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Gagal mengambil buku kategori ID $categoryId: $e');
    }
  }

  Future<BookModel> fetchBookDetail(int id) async {
    try {
      final response = await dio.get('${ApiEndpoints.bookDetail}/$id');
      final data = response.data['data'] as Map<String, dynamic>;
      return BookModel.fromJson(data);
    } catch (e) {
      throw Exception('Gagal mengambil detail buku ID $id: $e');
    }
  }
}