import 'package:flutter/material.dart';
import '../../../models/book_model.dart'; 

class BookListPage extends StatelessWidget {
  BookListPage({super.key});

  final List<BookModel> books = [
    BookModel(
      id: 1,
      title: 'Buku A',
      author: 'Penulis A',
      publisher: 'Penerbit A',
      year: 2020,
      stock: 5,
      borrowedCount: 2,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      description: 'Deskripsi A',
      coverUrl: 'https://example.com/cover-a.jpg',
      categoryId: 1,
      category: null,
    ),
    BookModel(
      id: 2,
      title: 'Buku B',
      author: 'Penulis B',
      publisher: 'Penerbit B',
      year: 2021,
      stock: 3,
      borrowedCount: 3,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      description: 'Deskripsi B',
      coverUrl: 'https://example.com/cover-b.jpg',
      categoryId: 2,
      category: null,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Buku')),
      body: ListView.builder(
        itemCount: books.length,
        itemBuilder: (context, index) {
          final book = books[index];
          return ListTile(
            leading: Image.network(book.coverUrl, width: 50, fit: BoxFit.cover),
            title: Text(book.title),
            subtitle: Text('Penulis: ${book.author}'),
            trailing: Text(book.isAvailable ? 'Tersedia' : 'Tidak tersedia'),
          );
        },
      ),
    );
  }
}
