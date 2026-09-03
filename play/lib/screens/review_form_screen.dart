import 'package:flutter/material.dart';

import '../models/movie.dart';
import '../models/review.dart';
import '../state/explorer_state.dart';
import '../widgets/page_shell.dart';

class ReviewFormScreen extends StatefulWidget {
  final ExplorerState state;
  final Movie movie;

  const ReviewFormScreen({super.key, required this.state, required this.movie});

  @override
  State<ReviewFormScreen> createState() => _ReviewFormScreenState();
}

class _ReviewFormScreenState extends State<ReviewFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _reviewController = TextEditingController();
  int _rating = 5;
  int _status = 1;
  bool _shareCheckbox = true;
  bool _notifySwitch = false;

  @override
  void initState() {
    super.initState();
    final existing = widget.state.reviewFor(widget.movie.id);
    if (existing != null) {
      _reviewController.text = existing.text;
      _rating = existing.rating;
      _status = existing.watched ? 1 : 2;
    }
  }

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final review = Review(
      movie: widget.movie,
      text: _reviewController.text.trim(),
      rating: _rating,
      watched: _status == 1,
    );
    widget.state.addReview(review);

    var confirmed = false;
    await showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        icon: const Icon(Icons.check_circle, color: Colors.green),
        title: const Text('Review submitted!'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Movie: ${widget.movie.title}'),
            const SizedBox(height: 6),
            Text('Rating: $_rating/10'),
            const SizedBox(height: 6),
            Text('Status: ${_status == 1 ? 'Watched' : 'Plan to watch'}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              confirmed = true;
              Navigator.pop(dialogContext);
            },
            child: const Text('Done'),
          ),
        ],
      ),
    );

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Review saved to your profile!')),
    );
    if (confirmed && mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Review: ${widget.movie.title}')),
      body: PageShell(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Text(
                'Share your thoughts',
                style: Theme.of(context).textTheme.titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                'Your review appears on the movie\u2019s details page.',
                style: TextStyle(color: Colors.grey.shade600),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _reviewController,
                maxLines: 4,
                maxLength: 200,
                decoration: const InputDecoration(
                  labelText: 'Your review',
                  hintText: 'What did you think of the movie?',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please write a short review.';
                  }
                  if (value.trim().length < 5) {
                    return 'Review must be at least 5 characters.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<int>(
                initialValue: _rating,
                decoration: const InputDecoration(
                  labelText: 'Rating',
                  border: OutlineInputBorder(),
                ),
                items: [
                  for (var i = 1; i <= 10; i++)
                    DropdownMenuItem(
                      value: i,
                      child: Row(
                        children: [
                          const Icon(Icons.star, size: 16, color: Colors.amber),
                          const SizedBox(width: 6),
                          Text('$i / 10'),
                        ],
                      ),
                    ),
                ],
                onChanged: (value) =>
                    setState(() => _rating = value ?? _rating),
              ),
              const SizedBox(height: 24),
              Text(
                'Status',
                style: Theme.of(context).textTheme.titleSmall
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              RadioGroup<int>(
                groupValue: _status,
                onChanged: (value) => setState(() => _status = value!),
                child: const Column(
                  children: [
                    RadioListTile<int>(
                      value: 1,
                      title: Text('I have watched this movie'),
                      secondary: Icon(Icons.check_circle_outline),
                    ),
                    RadioListTile<int>(
                      value: 2,
                      title: Text('I plan to watch it later'),
                      secondary: Icon(Icons.bookmark_add_outlined),
                    ),
                  ],
                ),
              ),
              const Divider(height: 24),
              CheckboxListTile(
                value: _shareCheckbox,
                onChanged: (value) =>
                    setState(() => _shareCheckbox = value ?? true),
                title: const Text('Show this review on my public profile'),
                secondary: const Icon(Icons.public),
                controlAffinity: ListTileControlAffinity.leading,
              ),
              SwitchListTile(
                value: _notifySwitch,
                onChanged: (value) => setState(() => _notifySwitch = value),
                title: const Text('Notify me about similar movies'),
                secondary: const Icon(Icons.notifications_active_outlined),
              ),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: _submit,
                icon: const Icon(Icons.send),
                label: const Text('Submit Review'),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
