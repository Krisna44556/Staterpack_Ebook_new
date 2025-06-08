import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/book_model.dart';
import '../domain/book_provider.dart';
import '../widgets/book_card.dart';

class BookListPage extends ConsumerStatefulWidget {
  const BookListPage({Key? key}) : super(key: key);

  @override
  ConsumerState<BookListPage> createState() => _BookListPageState();
}

class _BookListPageState extends ConsumerState<BookListPage> {
  String _searchQuery = '';
  String _selectedCategory = 'Semua';

  void _showBookPopup(BuildContext context, BookModel book) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(book.title),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: book.coverUrl.isNotEmpty
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          book.coverUrl,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      )
                    : const Icon(Icons.book, size: 100),
              ),
              const SizedBox(height: 12),
              Text('Penulis: ${book.author}', style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              Text('Kategori: ${book.categoryName}'),
              const SizedBox(height: 12),
              Text(book.description ?? 'Tidak ada deskripsi'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Tutup'),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Kamu meminjam buku "${book.title}"')),
              );
              // TODO: Panggil API pinjam di sini kalau sudah tersedia
            },
            icon: const Icon(Icons.shopping_cart),
            label: const Text('Pinjam Sekarang'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final asyncBooks = ref.watch(publicBooksProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Books')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Cari buku...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value.toLowerCase();
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Filter kategori',
                border: OutlineInputBorder(),
              ),
              value: _selectedCategory,
              items: ['Semua', 'Bisnis', 'Sejarah', 'Fiksi']
                  .map((kategori) => DropdownMenuItem(
                        value: kategori,
                        child: Text(kategori),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value!;
                });
              },
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: asyncBooks.when(
              data: (books) {
                final filteredBooks = books.where((book) {
                  final matchJudul = book.title.toLowerCase().contains(_searchQuery);
                  final matchKategori = _selectedCategory == 'Semua' ||
                      book.category?.toLowerCase() == _selectedCategory.toLowerCase();
                  return matchJudul && matchKategori;
                }).toList();

                if (filteredBooks.isEmpty) {
                  return const Center(child: Text('Tidak ada buku ditemukan'));
                }

                return GridView.builder(
                  padding: const EdgeInsets.all(8.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: filteredBooks.length,
                  itemBuilder: (context, index) {
                    final book = filteredBooks[index];
                    return BookCard(
                      book: book,
                      onTap: () => _showBookPopup(context, book),
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(child: Text('Error: $error')),
            ),
          ),
        ],
      ),
    );
  }
}
