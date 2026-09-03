import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import '../models/movie.dart';
import '../state/explorer_state.dart';
import '../widgets/movie_card.dart';
import '../widgets/page_shell.dart';

class ListingScreen extends StatelessWidget {
  final ExplorerState state;
  final String? category;
  final String? query;

  const ListingScreen({
    super.key,
    required this.state,
    this.category,
    this.query,
  });

  List<Movie> get _movies {
    if (category != null) {
      return allMovies.where((movie) => movie.category == category).toList();
    }
    if (query != null && query!.trim().isNotEmpty) {
      final term = query!.toLowerCase();
      return allMovies
          .where(
            (movie) =>
                movie.title.toLowerCase().contains(term) ||
                movie.category.toLowerCase().contains(term),
          )
          .toList();
    }
    return allMovies;
  }

  String get _title {
    if (category != null) return category!;
    if (query != null) return 'Results for \u201c$query\u201d';
    return 'All Movies';
  }

  @override
  Widget build(BuildContext context) {
    final movies = _movies;
    return Scaffold(
      appBar: AppBar(title: Text(_title)),
      body: PageShell(
        child: movies.isEmpty
            ? Center(
                child: Container(
                  margin: const EdgeInsets.all(32),
                  padding: const EdgeInsets.all(28),
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.search_off, size: 44, color: Colors.grey),
                      SizedBox(height: 12),
                      Text(
                        'No movies found',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Try a different category or search term.',
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              )
            : ListenableBuilder(
                listenable: state,
                builder: (context, _) => GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 220,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 0.62,
                  ),
                  itemCount: movies.length,
                  itemBuilder: (context, index) =>
                      MovieCard(movie: movies[index], state: state),
                ),
              ),
      ),
    );
  }
}
