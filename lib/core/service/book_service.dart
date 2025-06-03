import 'dart:convert';
import 'package:flutter/services.dart';
import '../../../models/book_model.dart';
import '../utils/book_utils.dart';

class BookService {
  /// Mengambil data buku dari assets (misalnya file JSON lokal)
  Future<List<BookModel>> fetchBooksFromAssets() async {
    try {
      final String response = await rootBundle.loadString('assets/data/books.json');
      final List<dynamic> data = json.decode(response);
      return data.map((json) => BookModel.fromJson(json)).toList();
    } catch (e) {
      print('Gagal memuat buku: $e');
      return [];
    }
  }

  /// Mengambil 10 buku paling populer
  Future<List<BookModel>> getPopularBooks() async {
    final books = await fetchBooksFromAssets();
    return BookUtils.getPopularBooks(books);
  }

  /// Mengambil daftar buku berdasarkan kategori
  Future<List<BookModel>> getBooksByCategory(String category) async {
    final books = await fetchBooksFromAssets();
    return BookUtils.getBooksByCategory(books, category);
  }

  /// Mengambil daftar buku berdasarkan tahun terbit
  Future<List<BookModel>> getBooksByYear(int year) async {
    final books = await fetchBooksFromAssets();
    return BookUtils.getBooksByYear(books, year);
  }

  /// Mengambil detail buku berdasarkan ID
Future<BookModel?> getBookById(int id) async {
  final books = await fetchBooksFromAssets();
  try {
    return books.firstWhere((book) => book.id == id);
  } catch (e) {
    return null; 
  }
}

}
