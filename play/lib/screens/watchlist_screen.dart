import 'package:flutter/material.dart';

import '../state/explorer_state.dart';
import '../widgets/movie_poster.dart';
import '../widgets/page_shell.dart';

class WatchlistScreen extends StatefulWidget {
  final ExplorerState state;

  const WatchlistScreen({super.key, required this.state});

  @override
  State<WatchlistScreen> createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {
  Future<void> _confirmRemove(BuildContext context, int index) async {
    final messenger = ScaffoldMessenger.of(context);
    final movie = widget.state.watchlist[index];
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
        title: const Text('Remove from watchlist?'),
        content: Text('\u201c${movie.title}\u201d will be removed.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            style: FilledButton.styleFrom(backgroundColor: Colors.redAccent),
            child: const Text('Remove'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;
    widget.state.removeFromWatchlist(movie.id);
    messenger.showSnackBar(
      SnackBar(content: Text('${movie.title} removed from watchlist')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final watchlist = widget.state.watchlist;
    final count = watchlist.length;
    final average = count == 0
        ? 0.0
        : watchlist.fold<double>(0, (sum, m) => sum + m.rating) / count;

    return Scaffold(
      appBar: AppBar(title: const Text('My Watchlist')),
      body: PageShell(
        child: ListenableBuilder(
          listenable: widget.state,
          builder: (context, _) {
            final movies = widget.state.watchlist;
            if (movies.isEmpty) {
              return Center(
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
                      Icon(Icons.bookmark_border, size: 44, color: Colors.grey),
                      SizedBox(height: 12),
                      Text(
                        'Your watchlist is empty',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text('Add movies from their details page.'),
                    ],
                  ),
                ),
              );
            }

            return Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Colors.indigo, Colors.deepPurple],
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: _SummaryItem(
                          icon: Icons.collections_bookmark,
                          label: 'Movies',
                          value: count.toString(),
                        ),
                      ),
                      Expanded(
                        child: _SummaryItem(
                          icon: Icons.star,
                          label: 'Avg rating',
                          value: average.toStringAsFixed(1),
                        ),
                      ),
                      Expanded(
                        child: _SummaryItem(
                          icon: Icons.schedule,
                          label: 'Total time',
                          value: count > 0 ? '${count * 2}h+' : '0h',
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    itemCount: movies.length,
                    itemBuilder: (context, index) {
                      final movie = movies[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        clipBehavior: Clip.antiAlias,
                        child: Row(
                          children: [
                            MoviePoster(
                              movie: movie,
                              height: 110,
                              width: 78,
                              borderRadius: 0,
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      movie.title,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.star,
                                          size: 14,
                                          color: Colors.amber,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          movie.rating.toStringAsFixed(1),
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          movie.category,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey.shade600,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '${movie.year} \u2022 ${movie.duration}',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            IconButton(
                              tooltip: 'Remove',
                              onPressed: () => _confirmRemove(context, index),
                              icon: const Icon(
                                Icons.delete_outline,
                                color: Colors.redAccent,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _SummaryItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 22),
        const SizedBox(height: 6),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
      ],
    );
  }
}
