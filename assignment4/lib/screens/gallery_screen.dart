import 'package:flutter/material.dart';

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  static const String routeName = '/gallery';

  static const List<String> _imagePaths = [
    'assets/images/img1.jpg',
    'assets/images/img2.jpg',
    'assets/images/img3.jpg',
    'assets/images/img4.jpg',
    'assets/images/img5.jpg',
    'assets/images/img6.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Images, Assets & Fonts')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Local images rendered with Image.asset()',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.primary,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              padding: const EdgeInsets.all(16),
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              children: [
                for (final path in _imagePaths)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      path,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}