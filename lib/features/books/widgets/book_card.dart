import 'package:flutter/material.dart';
import '../../../models/book_model.dart';

class BookCard extends StatelessWidget {
  final BookModel book;
  final VoidCallback? onTap;
  final VoidCallback? onBorrow;

  const BookCard({
    Key? key,
    required this.book,
    this.onTap,
    this.onBorrow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: ListTile(
        leading: book.coverUrl != null
            ? Image.network(book.coverUrl!, width: 50, fit: BoxFit.cover)
            : const Icon(Icons.book),
        title: Text(book.title),
        subtitle: Text(book.author),
        onTap: onTap,
        trailing: ElevatedButton(
          onPressed: onBorrow,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
          ),
          child: const Text('Pinjam'),
        ),
      ),
    );
  }
}
