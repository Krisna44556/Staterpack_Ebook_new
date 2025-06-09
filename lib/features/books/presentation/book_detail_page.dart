import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/service/borrow_service.dart';
import '../domain/book_provider.dart';

class BookDetailPage extends ConsumerWidget {
final int bookId;

const BookDetailPage({
Key? key,
required this.bookId,
}) : super(key: key);

Future<String?> _getToken() async {
final prefs = await SharedPreferences.getInstance();
return prefs.getString('token');
}

@override
Widget build(BuildContext context, WidgetRef ref) {
final asyncBook = ref.watch(singleBookProvider(bookId));


return Scaffold(
  appBar: AppBar(title: const Text('Detail Buku')),
  body: asyncBook.when(
    data: (book) {
      return FutureBuilder<String?>(
        future: _getToken(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final token = snapshot.data!;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.network(
                    book.coverUrl,
                    height: 220,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                        const Icon(Icons.broken_image, size: 100),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  book.title,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Chip(label: Text(book.categoryName)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber),
                    const SizedBox(width: 4),
                    Text('${book.rating}'),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  'Sinopsis',
                  style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(book.description),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      final borrowService = BorrowService();
                      final result = await borrowService.borrowBook(
                          bookId: bookId, token: token);
                      final success = result['success'] == true;

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(success
                              ? 'Berhasil mengajukan peminjaman.'
                              : 'Gagal mengajukan peminjaman.'),
                          backgroundColor:
                              success ? Colors.green : Colors.red,
                        ),
                      );
                    },
                    child: const Text('Pinjam Buku'),
                  ),
                )
              ],
            ),
          );
        },
      );
    },
    loading: () => const Center(child: CircularProgressIndicator()),
    error: (error, _) => Center(child: Text('Error: $error')),
  ),
);
}
}