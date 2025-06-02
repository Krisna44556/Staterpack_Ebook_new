import 'package:flutter/material.dart';
import '../../../models/book_model.dart';
import '../../../models/review_model.dart';
import '../data/book_review_repository.dart';


class BookDetailPage extends StatefulWidget {
  final BookModel book;

  const BookDetailPage({Key? key, required this.book}) : super(key: key);

  @override
  State<BookDetailPage> createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  final _repo = BookReviewRepository();
  final _commentController = TextEditingController();
  double _rating = 0.0;
  List<ReviewModel> _reviews = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadReviews();
  }

  Future<void> _loadReviews() async {
    try {
      if (widget.book.id == null) {
        throw Exception('Book ID tidak boleh null');
      }
      final reviews = await _repo.fetchReviews(widget.book.id!);
      setState(() {
        _reviews = reviews;
        _isLoading = false;
      });
    } catch (e) {
      print('Error fetching reviews: $e');
    }
  }

  Future<void> _submitReview() async {
    final review = ReviewModel(
      userId: 'user123', // Ganti sesuai user login
      comment: _commentController.text,
      rating: _rating,
    );

    try {
      await _repo.submitReview(widget.book.id, review);
      _commentController.clear();
      setState(() => _rating = 0.0);
      _loadReviews(); // refresh reviews
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Gagal mengirim review')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.book.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.book.title, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 10),
            Text(widget.book.description),
            const SizedBox(height: 20),

            // Review Section
            const Text('Beri Rating & Komentar', style: TextStyle(fontWeight: FontWeight.bold)),
            Slider(
              value: _rating,
              min: 0,
              max: 5,
              divisions: 10,
              label: _rating.toString(),
              onChanged: (value) {
                setState(() {
                  _rating = value;
                });
              },
            ),
            TextField(
              controller: _commentController,
              decoration: const InputDecoration(labelText: 'Komentar'),
            ),
            ElevatedButton(
              onPressed: _submitReview,
              child: const Text('Kirim Review'),
            ),

            const SizedBox(height: 20),
            const Text('Review Lainnya', style: TextStyle(fontWeight: FontWeight.bold)),
            _isLoading
                ? const CircularProgressIndicator()
                : Column(
                    children: _reviews
                        .map((r) => ListTile(
                              title: Text(r.comment),
                              subtitle: Text('Rating: ${r.rating}'),
                            ))
                        .toList(),
                  ),
          ],
        ),
      ),
    );
  }
}
