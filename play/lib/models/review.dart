import 'movie.dart';

class Review {
  final Movie movie;
  final String text;
  final int rating;
  final bool watched;

  const Review({
    required this.movie,
    required this.text,
    required this.rating,
    required this.watched,
  });
}