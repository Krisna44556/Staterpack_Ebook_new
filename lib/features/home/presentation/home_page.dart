import 'dart:async';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PageController _pageController;
  int _currentPage = 0;
  late Timer _timer;

  final List<Map<String, dynamic>> _carouselItems = [
    {
      'icon': Icons.explore,
      'title': 'Eksplor Buku',
      'desc': 'Jelajahi Buku Terbaru Yang Kamu Mau',
    },
    {
      'icon': Icons.event,
      'title': 'Author',
      'desc': 'Cek jadwal Author Yang Terkenal',
    },
    {
      'icon': Icons.star,
      'title': 'Info Buku Hits',
      'desc': 'Lihat Buku Yang Paling Hits',
    },
  ];

  @override
  void initState() {
    super.initState();

    _pageController = PageController(viewportFraction: 0.85);

    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_pageController.hasClients) {
        _currentPage++;
        if (_currentPage >= _carouselItems.length) {
          _currentPage = 0;
        }
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 30),
          const Icon(Icons.home, size: 60, color: Colors.teal),
          const SizedBox(height: 20),
          const Text(
            'Selamat datang di Dashboard!',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text(
            'Temukan fitur menarik di sini',
            style: TextStyle(fontSize: 16, color: Colors.red),
          ),
          const SizedBox(height: 30),
          SizedBox(
            height: 220,
            child: PageView.builder(
              controller: _pageController,
              itemCount: _carouselItems.length,
              itemBuilder: (context, index) {
                final item = _carouselItems[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    elevation: 5,
                    color: Colors.teal.shade50,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(item['icon'], size: 50, color: Colors.teal),
                          const SizedBox(height: 10),
                          Text(
                            item['title'],
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(item['desc'], style: const TextStyle(fontSize: 14)),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
