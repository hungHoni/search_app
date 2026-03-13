import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/models/saved_search.dart';
import '../../domain/repositories/bookmark_repository.dart';
import '../../infrastructure/firestore_bookmark_repository.dart';
import '../widgets/animated_fade_item.dart';
import '../widgets/result_list_view.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/services.dart';
import '../../core/utils/markdown_exporter.dart';
import '../../domain/repositories/search_repository.dart';
import '../../infrastructure/gemini_search_service.dart';
import '../widgets/shimmer_skeleton.dart';
import '../widgets/empty_state_view.dart';
import '../../infrastructure/purchase_service.dart';
import '../../infrastructure/daily_limit_service.dart';
import 'package:google_fonts/google_fonts.dart';

class BookmarksScreen extends StatefulWidget {
  const BookmarksScreen({super.key});

  @override
  State<BookmarksScreen> createState() => _BookmarksScreenState();
}

class _BookmarksScreenState extends State<BookmarksScreen> {
  final BookmarkRepository _bookmarkService = FirestoreBookmarkRepository();
  final String? _uid = FirebaseAuth.instance.currentUser?.uid;

  @override
  Widget build(BuildContext context) {
    if (_uid == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Saved Lessons')),
        body: const Center(child: Text('Must be logged in')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/search'),
        ),
        title: Text(
          "Saved History",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w400,
            letterSpacing: -0.5,
          ),
        ),
        scrolledUnderElevation: 0,
      ),
      body: SafeArea(
        child: StreamBuilder<List<SavedSearch>>(
          stream: _bookmarkService.watchSavedSearches(_uid),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const ShimmerSkeleton(lines: 4);
            }

            if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error loading Bookmarks',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              );
            }

            final bookmarks = snapshot.data ?? [];
            if (bookmarks.isEmpty) {
              return EmptyStateView(
                icon: Icons.bookmark_border,
                headline: "No saved lessons yet",
                subtitle:
                    "Search for a topic, then tap Save Lesson to build your personal library.",
                actionLabel: "START LEARNING",
                onAction: () => context.go('/search'),
              );
            }

            return ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              itemCount: bookmarks.length,
              separatorBuilder: (context, index) =>
                  const Divider(height: 32, color: Color(0xFFEEEEEE)),
              itemBuilder: (context, index) {
                final item = bookmarks[index];
                return AnimatedFadeItem(
                  delay: Duration(milliseconds: 100 + (index * 50)),
                  child: InkWell(
                    onTap: () {
                      context.push('/bookmarks/detail', extra: item);
                    },
                    borderRadius: BorderRadius.circular(8),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.query.toUpperCase(),
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: -0.5,
                                ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Saved on ${item.timestamp.toLocal().toString().split(' ')[0]}",
                            style: Theme.of(context).textTheme.labelSmall
                                ?.copyWith(color: Theme.of(context).hintColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class SavedDetailScreen extends StatefulWidget {
  final SavedSearch savedSearch;

  const SavedDetailScreen({super.key, required this.savedSearch});

  @override
  State<SavedDetailScreen> createState() => _SavedDetailScreenState();
}

class _SavedDetailScreenState extends State<SavedDetailScreen> {
  bool _isGenerating = false;
  late SavedSearch _currentSearch;
  final SearchRepository _searchService = GeminiSearchService();
  final BookmarkRepository _bookmarkService = FirestoreBookmarkRepository();

  @override
  void initState() {
    super.initState();
    _currentSearch = widget.savedSearch;
  }

  Future<void> _generateFlashcards() async {
    if (!PurchaseService().isPremium) {
      if (mounted) {
        final didPurchase = await context.push<bool>(
          '/paywall?q=${Uri.encodeComponent('Flashcards: ${_currentSearch.query}')}',
        );
        if (didPurchase != true) {
          return;
        }
      }
    }

    if (!await DailyLimitService().canGenerate()) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Daily limit of 5 custom AI generations reached. Rest your brain until tomorrow!',
              style: GoogleFonts.inter(color: Colors.white),
            ),
            backgroundColor: const Color(0xFF222222),
          ),
        );
      }
      return;
    }

    setState(() => _isGenerating = true);
    try {
      final flashcards = await _searchService.generateFlashcards(
        _currentSearch.query,
        _currentSearch.results,
      );

      final updatedSearch = SavedSearch(
        id: _currentSearch.id,
        query: _currentSearch.query,
        timestamp: _currentSearch.timestamp,
        results: _currentSearch.results,
        flashcards: flashcards,
      );

      await _bookmarkService.updateSearch(updatedSearch);
      await DailyLimitService().incrementGeneration();

      if (mounted) {
        setState(() {
          _currentSearch = updatedSearch;
          _isGenerating = false;
        });
        context.push('/flashcards', extra: flashcards);
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isGenerating = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Failed: $e"),
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasFlashcards =
        _currentSearch.flashcards != null &&
        _currentSearch.flashcards!.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: Text(
          _currentSearch.query.toUpperCase(),
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w400,
            fontSize: 22,
          ),
        ),
        scrolledUnderElevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              Icons.copy,
              color: Theme.of(context).colorScheme.primary,
            ),
            tooltip: 'Export to Notion (Markdown)',
            onPressed: () async {
              final markdown = MarkdownExporter.exportToNotion(_currentSearch);
              await Clipboard.setData(ClipboardData(text: markdown));
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text(
                      "Markdown copied! Paste smoothly into Notion.",
                    ),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            },
          ),
          const SizedBox(width: 8),
          if (hasFlashcards)
            TextButton.icon(
              onPressed: () {
                context.push('/flashcards', extra: _currentSearch.flashcards);
              },
              icon: Icon(
                Icons.style,
                color: Theme.of(context).colorScheme.primary,
              ),
              label: Text(
                "STUDY",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          else
            TextButton.icon(
              onPressed: _isGenerating ? null : _generateFlashcards,
              icon: _isGenerating
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Icon(
                      Icons.auto_awesome,
                      color: Theme.of(context).colorScheme.primary,
                    ),
              label: Text(
                _isGenerating ? "GENERATING..." : "FLASHCARDS",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          const SizedBox(width: 16),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: ResultListView(results: _currentSearch.results),
        ),
      ),
    );
  }
}
