import 'package:sungokong_book/models/book_model.dart';

class BookUtils {
  /// Mengambil daftar buku paling populer berdasarkan jumlah dipinjam (borrowedCount)
  static List<BookModel> getPopularBooks(List<BookModel> books, {int count = 5}) {
    books.sort((a, b) => b.borrowedCount.compareTo(a.borrowedCount));
    return books.take(count).toList();
  }

 /// Mengambil daftar buku berdasarkan nama kategori (tidak case-sensitive)
static List<BookModel> getBooksByCategory(List<BookModel> books, String category) {
  return books
  
      .where((book) =>
          book.category?.name.toLowerCase() == category.toLowerCase())
      .toList();
}


  /// Mengambil buku berdasarkan ID
  static BookModel? getBookById(List<BookModel> books, int id) {
    try {
      return books.firstWhere((book) => book.id == id);
    } catch (_) {
      return null;
    }
  }

  /// Mengambil daftar buku yang tersedia (quantity > borrowedCount)
  static List<BookModel> getAvailableBooks(List<BookModel> books) {
    return books.where((book) => book.isAvailable == true).toList();
  }

 /// Mengambil daftar buku berdasarkan tahun terbit
static List<BookModel> getBooksByYear(List<BookModel> books, int year) {
  return books.where((book) => book.year == year).toList();
}

}
