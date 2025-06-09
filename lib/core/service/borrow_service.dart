import 'dart:convert';
import 'package:http/http.dart' as http;

class BorrowService {
  final String baseUrl = 'http://127.0.0.1:8000'; // Ganti dengan URL API-mu

  // Fungsi untuk mengajukan peminjaman buku
  Future<Map<String, dynamic>> borrowBook({
    required int bookId,
    required String token,
  }) async {
    final url = Uri.parse('$baseUrl/loans');
    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'book_id': bookId,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        throw Exception('Gagal meminjam buku: ${response.body}');
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan: $e');
    }
  }
}