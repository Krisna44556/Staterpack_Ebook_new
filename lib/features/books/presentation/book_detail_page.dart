import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/book_model.dart';
import '../domain/book_provider.dart';

class BookDetailPage extends ConsumerWidget {
  final int bookId;

  const BookDetailPage({Key? key, required this.bookId}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncBook = ref.watch(singleBookProvider(bookId)); // Buat provider ini di book_provider.dart

    return Scaffold(
      appBar: AppBar(title: const Text('Detail Buku')),
      body: asyncBook.when(
        data: (book) {
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
                    errorBuilder: (_, __, ___) => const Icon(Icons.broken_image, size: 100),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  book.title,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Chip(label: Text(book.category)),
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
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(book.description),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Logika pinjam buku bisa dipasang di sini
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Fitur peminjaman belum diaktifkan')),
                      );
                    },
                    child: const Text('Pinjam Buku'),
                  ),
                )
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
      ),
    );
  }
  
  ProviderListenable singleBookProvider(int bookId) {
    throw UnimplementedError('singleBookProvider is not implemented.');
  }
}
