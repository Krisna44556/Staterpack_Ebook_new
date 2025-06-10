import 'package:flutter/material.dart';
import '../../../models/book_model.dart';

class BookCard extends StatelessWidget {
  final BookModel book;
  final VoidCallback onTap;

  const BookCard({
    Key? key,
    required this.book,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        leading: book.imageUrl.isNotEmpty
            ? Image.network(
                book.imageUrl,
                width: 50,
                height: 70,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.broken_image),
              )
            : const SizedBox(
                width: 50,
                height: 70,
                child: Icon(Icons.book),
              ),
        title: Text(book.title),
        subtitle: Text(
          'Penulis: ${book.author}\nKategori: ${book.category ?? 'Tidak ada kategori'}',
        ),
        isThreeLine: true,
        onTap: onTap,
      ),
    );
  }
}
