import 'package:flutter/material.dart';

import '../../domain/models/search_result.dart';
import '../../domain/repositories/search_repository.dart';
import '../../infrastructure/gemini_search_service.dart';
import '../../infrastructure/firestore_bookmark_repository.dart';
import '../../domain/repositories/bookmark_repository.dart';
import '../widgets/animated_fade_item.dart';
import '../widgets/result_list_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import '../widgets/shimmer_skeleton.dart';
import '../widgets/empty_state_view.dart';
import '../../infrastructure/suggestion_service.dart';

class SearchScreen extends StatefulWidget {
  final String? initialQuery;

  const SearchScreen({super.key, this.initialQuery});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  // Dependency injection (simplified for this minimal app)
  final SearchRepository _searchService = GeminiSearchService();
  final BookmarkRepository _bookmarkService = FirestoreBookmarkRepository();

  bool _isLoading = false;
  bool _isSaving = false;
  List<SearchResult> _results = [];
  String? _errorMessage;
  bool _isPersonalized = false;

  List<Map<String, dynamic>> _shuffledKeywords = [];

  @override
  void initState() {
    super.initState();
    _shuffleEditorialKeywords();
    _loadPersonalizedSuggestions(); // Async — will update chips when ready

    // If the router deep-linked us directly to a search query, execute it immediately
    if (widget.initialQuery != null && widget.initialQuery!.isNotEmpty) {
      _searchController.text = widget.initialQuery!;
      // Delay slightly to let the UI build the loading state cleanly
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _executeSearch(widget.initialQuery!);
      });
    }
  }

  /// Attempts to load personalized topic suggestions from Gemini
  /// based on the user's bookmark history. If successful, replaces
  /// the static keyword chips. Falls back silently on failure.
  Future<void> _loadPersonalizedSuggestions() async {
    final service = SuggestionService();
    final suggestions = await service.generatePersonalizedSuggestions();
    if (suggestions.isNotEmpty && mounted) {
      // Convert plain strings into the editorial keyword format
      const sizes = [28.0, 18.0, 22.0, 14.0, 32.0, 20.0];
      const weights = [
        FontWeight.w300,
        FontWeight.w400,
        FontWeight.w300,
        FontWeight.w600,
        FontWeight.w300,
        FontWeight.w400,
      ];

      int delay = 400;
      final personalized = suggestions.asMap().entries.map((entry) {
        final i = entry.key;
        final text = entry.value;
        delay += 50;
        return <String, dynamic>{
          'text': text,
          'size': sizes[i % sizes.length],
          'weight': weights[i % weights.length],
          'delay': delay,
        };
      }).toList();

      setState(() {
        _shuffledKeywords = personalized;
        _isPersonalized = true;
      });
    }
  }

  @override
  void didUpdateWidget(SearchScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialQuery != oldWidget.initialQuery) {
      if (widget.initialQuery != null && widget.initialQuery!.isNotEmpty) {
        if (_searchController.text != widget.initialQuery) {
          _searchController.text = widget.initialQuery!;
        }
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _executeSearch(widget.initialQuery!);
        });
      } else {
        // Navigating back to the idle home state
        setState(() {
          _results = [];
          _errorMessage = null;
        });
      }
    }
  }

  void _shuffleEditorialKeywords() {
    final pool = [
      {'text': 'SYSTEM DESIGN', 'size': 24.0, 'weight': FontWeight.w300},
      {'text': 'Data Structures', 'size': 18.0, 'weight': FontWeight.w400},
      {
        'text': 'ALGORITHMS',
        'size': 14.0,
        'weight': FontWeight.w600,
        'spacing': 2.0,
      },
      {'text': 'Machine Learning', 'size': 32.0, 'weight': FontWeight.w300},
      {'text': 'O(n) Complexity', 'size': 16.0, 'weight': FontWeight.w500},
      {'text': 'Microservices', 'size': 20.0, 'weight': FontWeight.w300},
      {'text': 'REST APIs', 'size': 28.0, 'weight': FontWeight.w300},
      {'text': 'GraphQL', 'size': 22.0, 'weight': FontWeight.w400},
      {'text': 'SOLID Principles', 'size': 14.0, 'weight': FontWeight.w500},
      {'text': 'Docker', 'size': 26.0, 'weight': FontWeight.w200},
      {'text': 'Concurrency', 'size': 18.0, 'weight': FontWeight.w400},
    ];

    pool.shuffle();
    final selected = pool.take(6).toList();

    // Assign staggered delays for the entrance animation
    int delay = 400;
    _shuffledKeywords = selected.map((item) {
      final copy = Map<String, dynamic>.from(item);
      copy['delay'] = delay;
      delay += 50;
      return copy;
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _submitSearch(String query) {
    if (query.trim().isEmpty) return;

    // Instead of doing the work locally, push a new URL to the router.
    // This allows the browser back button to work naturally.
    context.go('/search?q=${Uri.encodeComponent(query)}');
  }

  void _executeSearch(String query) async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final results = await _searchService.fetchResults(query);
      if (mounted) {
        setState(() {
          _results = results;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = e.toString().replaceFirst(
            'Exception: ',
            '',
          ); // Clean up the raw flutter exception prefix
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // We use a responsive layout that changes based on whether a search has occurred.
    // If not searched, the input is vertically centered via Expanded/Center. If searched, it pins up.

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 16.0,
              ),
              child: Column(
                children: [
                  if (widget.initialQuery != null) ...[
                    // When actively searching, we want the bar pinned to the top.
                    _buildSearchBar(context),
                    const SizedBox(height: 32),
                    Expanded(child: _buildBody()),
                  ] else ...[
                    // When idle, we want a scrollable, centered editorial experience.
                    Expanded(
                      child: Center(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // 1. Hero Headline
                              AnimatedFadeItem(
                                delay: const Duration(milliseconds: 100),
                                child: Text(
                                  "What will you\nmaster today?",
                                  style: Theme.of(context).textTheme.titleLarge
                                      ?.copyWith(
                                        fontSize: 48,
                                        height: 1.1,
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: -1.5,
                                      ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              const SizedBox(height: 48),
                              // 2. Animated Search Bar
                              AnimatedFadeItem(
                                delay: const Duration(milliseconds: 250),
                                child: _buildSearchBar(context),
                              ),
                              const SizedBox(height: 64),
                              // 3. Personalized label or staggered grid
                              if (_isPersonalized)
                                AnimatedFadeItem(
                                  delay: const Duration(milliseconds: 350),
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 16),
                                    child: Text(
                                      "SUGGESTED FOR YOU",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall
                                          ?.copyWith(
                                            letterSpacing: 3.0,
                                            fontWeight: FontWeight.w700,
                                            color: Theme.of(context).hintColor,
                                          ),
                                    ),
                                  ),
                                ),
                              _buildStaggeredEditorialGrid(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (widget.initialQuery == null)
              Positioned(
                top: 16,
                right: 24,
                child: IconButton(
                  icon: const Icon(Icons.bookmarks_outlined, size: 28),
                  onPressed: () {
                    context.push('/bookmarks');
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildStaggeredEditorialGrid() {
    return Wrap(
      spacing: 24.0,
      runSpacing: 24.0,
      alignment: WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: _shuffledKeywords.map((item) {
        return AnimatedFadeItem(
          delay: Duration(milliseconds: item['delay'] as int),
          child: InkWell(
            onTap: () {
              // Convert to title case nicely for the input box
              final query = (item['text'] as String)
                  .toLowerCase()
                  .split(' ')
                  .map(
                    (w) => w.isNotEmpty
                        ? '${w[0].toUpperCase()}${w.substring(1)}'
                        : '',
                  )
                  .join(' ');

              _searchController.text = query;
              _submitSearch(query);
            },
            overlayColor: WidgetStateProperty.all(Colors.transparent),
            child: Text(
              item['text'] as String,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: item['size'] as double,
                fontWeight: item['weight'] as FontWeight,
                letterSpacing: item['spacing'] as double? ?? 0.0,
                color: Theme.of(
                  context,
                ).colorScheme.primary.withValues(alpha: 0.8),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _searchController,
          focusNode: _focusNode,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w400,
            fontSize: 28,
          ),
          decoration: InputDecoration(
            hintText: 'Type a concept...',
            hintStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w300,
              fontSize: 28,
              color: Theme.of(context).hintColor,
            ),
            contentPadding: const EdgeInsets.only(bottom: 8),
            isDense: true,
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
          ),
          textInputAction: TextInputAction.search,
          onSubmitted: _submitSearch,
          autofocus: true,
        ),
        // Custom animated editorial underline
        AnimatedBuilder(
          animation: _focusNode,
          builder: (context, child) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
              height: 2,
              // Expand underline to full width when focused, otherwise subtle grey
              width: _focusNode.hasFocus
                  ? MediaQuery.of(context).size.width
                  : 40,
              color: _focusNode.hasFocus
                  ? Theme.of(context).colorScheme.primary
                  : const Color(0xFFEEEEEE),
            );
          },
        ),
      ],
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const ShimmerSkeleton(lines: 5);
    }

    if (_errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Text(
            _errorMessage!,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(
                context,
              ).colorScheme.primary, // Enforce strict monochrome palette
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    if (_results.isEmpty) {
      return const EmptyStateView(
        icon: Icons.search_off,
        headline: "No insights found",
        subtitle: "Try a different topic or rephrase your query.",
      );
    }

    return Column(
      children: [
        Expanded(child: ResultListView(results: _results)),
        const SizedBox(height: 16),
        _buildActionRow(),
      ],
    );
  }

  Widget _buildActionRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Sign Out Button (Utility)
        TextButton.icon(
          onPressed: () {
            FirebaseAuth.instance.signOut();
          },
          icon: Icon(
            Icons.logout,
            size: 16,
            color: Theme.of(context).hintColor,
          ),
          label: Text(
            "Logout",
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: Theme.of(context).hintColor,
            ),
          ),
        ),

        // Save Bookmark Button
        ElevatedButton.icon(
          onPressed: _isSaving ? null : _saveCurrentSearch,
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
          icon: _isSaving
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : const Icon(Icons.bookmark_border, size: 18),
          label: Text(
            _isSaving ? "SAVING..." : "SAVE LESSON",
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: Colors.white,
              letterSpacing: 1.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _saveCurrentSearch() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null || _results.isEmpty) return;

    setState(() => _isSaving = true);

    try {
      await _bookmarkService.saveSearch(
        user.uid,
        _searchController.text.trim(),
        _results,
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text("Lesson saved successfully!"),
            backgroundColor: Theme.of(context).colorScheme.primary,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text("Failed to save lesson."),
            backgroundColor: Theme.of(
              context,
            ).colorScheme.primary, // Enforce strict monochrome palette
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }
}
