import 'package:flutter/material.dart';

import 'animation_screen.dart';
import 'form_screen.dart';
import 'gallery_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const String routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Assignment 4'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Demonstrating Forms, Assets & Fonts, and Animations',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            _ConceptCard(
              icon: Icons.edit_note,
              title: 'User Input & Forms',
              description: 'Validated form with TextFormFields',
              color: Colors.purple,
              onTap: () => Navigator.pushNamed(context, FormScreen.routeName),
            ),
            const SizedBox(height: 16),
            _ConceptCard(
              icon: Icons.photo_library,
              title: 'Images, Assets & Fonts',
              description: 'Local images in a grid with a custom font',
              color: Colors.teal,
              onTap: () =>
                  Navigator.pushNamed(context, GalleryScreen.routeName),
            ),
            const SizedBox(height: 16),
            _ConceptCard(
              icon: Icons.animation,
              title: 'Animations',
              description: 'AnimatedContainer morphing demo',
              color: Colors.orange,
              onTap: () =>
                  Navigator.pushNamed(context, AnimationScreen.routeName),
            ),
          ],
        ),
      ),
    );
  }
}

class _ConceptCard extends StatelessWidget {
  const _ConceptCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String description;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          backgroundColor: color,
          child: Icon(icon, color: Colors.white),
        ),
        title: Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(description),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}