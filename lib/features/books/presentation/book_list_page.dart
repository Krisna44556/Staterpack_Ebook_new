import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/book_model.dart';
import '../domain/book_provider.dart';
import '../widgets/book_card.dart';

class BookListPage extends ConsumerWidget {
  const BookListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncBooks = ref.watch(publicBooksProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Books')),
      body: asyncBooks.when(
        data: (books) {
          if (books.isEmpty) {
            return const Center(child: Text('No books available'));
          }
          return ListView.builder(
            itemCount: books.length,
            itemBuilder: (context, index) {
              final book = books[index];
              return BookCard(
                book: book,
                onTap: () {
                  // TODO: Navigasi ke detail buku
                },
                onBorrow: () {
                  if (book.isAvailable) {
                    // TODO: tambahkan logika penyimpanan jika perlu
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Berhasil meminjam "${book.title}"')),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('"${book.title}" sedang tidak tersedia')),
                    );
                  }
                },
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
