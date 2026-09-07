import 'package:flutter/material.dart';

class AnimationScreen extends StatefulWidget {
  const AnimationScreen({super.key});

  static const String routeName = '/animation';

  @override
  State<AnimationScreen> createState() => _AnimationScreenState();
}

class _AnimationScreenState extends State<AnimationScreen> {
  bool _expanded = false;

  void _toggle() {
    setState(() {
      _expanded = !_expanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Animations')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              width: _expanded ? 220 : 120,
              height: _expanded ? 220 : 120,
              decoration: BoxDecoration(
                color: _expanded ? Colors.deepPurple : Colors.orange,
                borderRadius: BorderRadius.circular(_expanded ? 40 : 8),
                boxShadow: [
                  BoxShadow(
                    color: (_expanded ? Colors.deepPurple : Colors.orange)
                        .withValues(alpha: 0.4),
                    blurRadius: _expanded ? 24 : 8,
                    offset: const Offset(4, 8),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: Icon(
                _expanded ? Icons.celebration : Icons.compress,
                color: Colors.white,
                size: _expanded ? 64 : 32,
              ),
            ),
            const SizedBox(height: 40),
            FilledButton.icon(
              onPressed: _toggle,
              icon: Icon(_expanded ? Icons.minimize : Icons.expand),
              label: Text(_expanded ? 'Shrink' : 'Expand'),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 14,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Tap the button to animate size, color,\nborder radius and shadow.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}