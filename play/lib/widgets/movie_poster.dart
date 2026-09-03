import 'package:flutter/material.dart';

import '../models/movie.dart';

class MoviePoster extends StatelessWidget {
  final Movie movie;
  final double height;
  final double? width;
  final double borderRadius;

  const MoviePoster({
    super.key,
    required this.movie,
    required this.height,
    this.width,
    this.borderRadius = 12,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: SizedBox(
        width: width ?? double.infinity,
        height: height,
        child: Image.network(
          movie.imageUrl,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) =>
              _PosterFallback(movie: movie),
        ),
      ),
    );
  }
}

class _PosterFallback extends StatelessWidget {
  final Movie movie;

  const _PosterFallback({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.indigo,
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.movie_outlined, size: 40, color: Colors.white70),
          const SizedBox(height: 12),
          Text(
            movie.title,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
