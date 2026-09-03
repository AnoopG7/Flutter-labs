import 'package:flutter/foundation.dart';

import '../models/movie.dart';
import '../models/review.dart';

class ExplorerState extends ChangeNotifier {
  final List<Movie> _watchlist = [];
  final Set<String> _watchlistIds = {};
  final List<Review> _reviews = [];

  List<Movie> get watchlist => List.unmodifiable(_watchlist);

  List<Review> get reviews => List.unmodifiable(_reviews);

  bool isInWatchlist(String id) => _watchlistIds.contains(id);

  Review? reviewFor(String id) {
    for (final review in _reviews) {
      if (review.movie.id == id) return review;
    }
    return null;
  }

  void addToWatchlist(Movie movie) {
    if (!_watchlistIds.add(movie.id)) return;
    _watchlist.add(movie);
    notifyListeners();
  }

  void removeFromWatchlist(String id) {
    if (!_watchlistIds.remove(id)) return;
    _watchlist.removeWhere((movie) => movie.id == id);
    notifyListeners();
  }

  void addReview(Review review) {
    _reviews.removeWhere((r) => r.movie.id == review.movie.id);
    _reviews.add(review);
    notifyListeners();
  }
}