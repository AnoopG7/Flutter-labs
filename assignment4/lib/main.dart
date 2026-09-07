import 'package:flutter/material.dart';

import 'screens/animation_screen.dart';
import 'screens/form_screen.dart';
import 'screens/gallery_screen.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const Assignment4App());
}

class Assignment4App extends StatelessWidget {
  const Assignment4App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Assignment 4',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        fontFamily: 'Roboto',
      ),
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName: (_) => const HomeScreen(),
        FormScreen.routeName: (_) => const FormScreen(),
        GalleryScreen.routeName: (_) => const GalleryScreen(),
        AnimationScreen.routeName: (_) => const AnimationScreen(),
      },
    );
  }
}