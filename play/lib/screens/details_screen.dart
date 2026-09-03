import 'package:flutter/material.dart';

import '../models/movie.dart';
import '../models/review.dart';
import '../state/explorer_state.dart';
import '../widgets/movie_poster.dart';
import '../widgets/page_shell.dart';
import 'review_form_screen.dart';

class DetailsScreen extends StatelessWidget {
  final ExplorerState state;
  final Movie movie;

  const DetailsScreen({super.key, required this.state, required this.movie});

  void _toggleWatchlist(BuildContext context) {
    if (state.isInWatchlist(movie.id)) {
      state.removeFromWatchlist(movie.id);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${movie.title} removed from watchlist')),
      );
    } else {
      state.addToWatchlist(movie);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${movie.title} added to watchlist')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return ListenableBuilder(
      listenable: state,
      builder: (context, _) {
        final isSaved = state.isInWatchlist(movie.id);
        final savedReview = state.reviewFor(movie.id);
        return Scaffold(
          body: PageShell(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Stack(
                  children: [
                    MoviePoster(movie: movie, height: 300, borderRadius: 0),
                    Positioned(
                      top: 24,
                      left: 8,
                      child: IconButton(
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.black45,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back),
                      ),
                    ),
                    Positioned(
                      top: 24,
                      right: 8,
                      child: IconButton(
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.black45,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () => _toggleWatchlist(context),
                        icon: Icon(
                          isSaved ? Icons.bookmark : Icons.bookmark_border,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movie.title,
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.star, size: 18, color: Colors.amber),
                          const SizedBox(width: 4),
                          Text(
                            movie.rating.toStringAsFixed(1),
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(width: 16),
                          const Icon(Icons.calendar_today, size: 16),
                          const SizedBox(width: 4),
                          Text(movie.year),
                          const SizedBox(width: 16),
                          const Icon(Icons.schedule, size: 16),
                          const SizedBox(width: 4),
                          Text(movie.duration),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: scheme.primaryContainer,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          movie.category,
                          style: TextStyle(
                            color: scheme.onPrimaryContainer,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'About the movie',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        movie.description,
                        style: TextStyle(
                          fontSize: 15,
                          height: 1.5,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      const SizedBox(height: 24),
                      FilledButton.icon(
                        onPressed: () => _toggleWatchlist(context),
                        icon: Icon(
                          isSaved ? Icons.bookmark_remove : Icons.bookmark_add,
                        ),
                        label: Text(
                          isSaved
                              ? 'Remove from Watchlist'
                              : 'Add to Watchlist',
                        ),
                      ),
                      const SizedBox(height: 8),
                      OutlinedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  ReviewFormScreen(state: state, movie: movie),
                            ),
                          );
                        },
                        icon: const Icon(Icons.rate_review_outlined),
                        label: Text(
                          savedReview == null
                              ? 'Write a Review'
                              : 'Edit Your Review',
                        ),
                      ),
                      if (savedReview != null) ...[
                        const SizedBox(height: 20),
                        _ReviewCard(review: savedReview),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ReviewCard extends StatelessWidget {
  final Review review;

  const _ReviewCard({required this.review});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Card(
      elevation: 1,
      color: scheme.surfaceContainerHighest,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.star, size: 18, color: Colors.amber),
                const SizedBox(width: 4),
                Text(
                  '${review.rating}/10',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: review.watched
                        ? Colors.green.shade50
                        : scheme.secondaryContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    review.watched ? 'Watched' : 'Plan to watch',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: review.watched
                          ? Colors.green.shade800
                          : scheme.onSecondaryContainer,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(review.text, style: const TextStyle(height: 1.4)),
          ],
        ),
      ),
    );
  }
}
