import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import '../state/explorer_state.dart';
import '../widgets/page_shell.dart';
import 'listing_screen.dart';
import 'watchlist_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ExplorerState _state = ExplorerState();
  final TextEditingController _searchController = TextEditingController();
  int _tabIndex = 0;

  @override
  void dispose() {
    _searchController.dispose();
    _state.dispose();
    super.dispose();
  }

  void _openListing({String? category, String? query}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            ListingScreen(state: _state, category: category, query: query),
      ),
    );
  }

  void _submitSearch(String value) {
    if (value.trim().isEmpty) return;
    _openListing(query: value.trim());
    _searchController.clear();
  }

  void _showAbout() {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        icon: const Icon(Icons.movie_creation_outlined),
        title: const Text('Movie Explorer'),
        content: const Text(
          'A front-end only Flutter mini project.\n\nBrowse categories, '
          'view movie details, write reviews and build your personal '
          'watchlist.\n\nAll data is hard-coded mock data.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Movie Explorer')),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.indigo, Colors.deepPurple],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Icon(Icons.movie_creation, color: Colors.white, size: 40),
                  SizedBox(height: 8),
                  Text(
                    'Movie Explorer',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Browse \u2022 Review \u2022 Save',
                    style: TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home_outlined),
              title: const Text('Home'),
              selected: _tabIndex == 0,
              onTap: () {
                setState(() => _tabIndex = 0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.grid_view_outlined),
              title: const Text('Browse All Movies'),
              onTap: () {
                Navigator.pop(context);
                _openListing();
              },
            ),
            ListTile(
              leading: const Icon(Icons.collections_bookmark_outlined),
              title: const Text('My Watchlist'),
              selected: _tabIndex == 2,
              onTap: () {
                setState(() => _tabIndex = 2);
                Navigator.pop(context);
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('About'),
              onTap: () {
                Navigator.pop(context);
                _showAbout();
              },
            ),
          ],
        ),
      ),
      body: PageShell(
        child: IndexedStack(
          index: _tabIndex,
          children: [
            _MoviesTab(
              searchController: _searchController,
              onSearch: _submitSearch,
              onCategoryTap: (category) => _openListing(category: category),
              onSeeAll: () => _openListing(),
            ),
            ListingScreen(state: _state),
            WatchlistScreen(state: _state),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _tabIndex,
        onDestinationSelected: (index) => setState(() => _tabIndex = index),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.grid_view_outlined),
            selectedIcon: Icon(Icons.grid_view),
            label: 'Movies',
          ),
          NavigationDestination(
            icon: Icon(Icons.collections_bookmark_outlined),
            selectedIcon: Icon(Icons.collections_bookmark),
            label: 'Watchlist',
          ),
        ],
      ),
    );
  }
}

class _MoviesTab extends StatelessWidget {
  final TextEditingController searchController;
  final ValueChanged<String> onSearch;
  final ValueChanged<String> onCategoryTap;
  final VoidCallback onSeeAll;

  const _MoviesTab({
    required this.searchController,
    required this.onSearch,
    required this.onCategoryTap,
    required this.onSeeAll,
  });

  @override
  Widget build(BuildContext context) {
    final categoryCard = movieCategories[0];
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Stack(
            children: [
              SizedBox(
                height: 170,
                width: double.infinity,
                child: Image.network(
                  'https://picsum.photos/seed/movie-banner/800/400',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.indigo, Colors.deepPurple],
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: 170,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Colors.black.withValues(alpha: 0.75),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 20,
                top: 0,
                bottom: 0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Movie Explorer',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Discover. Review. Watchlist.',
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      onPressed: onSeeAll,
                      icon: const Icon(Icons.play_arrow),
                      label: const Text('Explore now'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        TextField(
          controller: searchController,
          textInputAction: TextInputAction.search,
          onSubmitted: onSearch,
          decoration: InputDecoration(
            hintText: 'Search movies or categories...',
            prefixIcon: const Icon(Icons.search),
            suffixIcon: IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () => searchController.clear(),
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 14,
            ),
          ),
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Categories',
              style: Theme.of(context).textTheme.titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            TextButton(onPressed: onSeeAll, child: const Text('See all')),
          ],
        ),
        const SizedBox(height: 4),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.8,
          ),
          itemCount: movieCategories.length,
          itemBuilder: (context, index) {
            final category = movieCategories[index];
            return _CategoryCard(
              category: category,
              onTap: () => onCategoryTap(category.name),
            );
          },
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Popular now',
              style: Theme.of(context).textTheme.titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            TextButton(onPressed: onSeeAll, child: const Text('See all')),
          ],
        ),
        const SizedBox(height: 4),
        Card(
          clipBehavior: Clip.antiAlias,
          elevation: 3,
          child: InkWell(
            onTap: () => onCategoryTap(categoryCard.name),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  const Icon(
                    Icons.local_fire_department,
                    color: Colors.deepOrange,
                    size: 32,
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Top Action Picks',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'High-octane movies hand-picked for you',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  const Icon(Icons.chevron_right),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final Category category;
  final VoidCallback onTap;

  const _CategoryCard({required this.category, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primaryContainer,
                Theme.of(context).colorScheme.secondaryContainer,
              ],
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(category.icon, color: Theme.of(context).colorScheme.primary),
              const SizedBox(width: 10),
              Text(
                category.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
