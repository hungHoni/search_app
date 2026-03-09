import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/models/saved_search.dart';
import '../../domain/repositories/bookmark_repository.dart';
import '../../infrastructure/firestore_bookmark_repository.dart';
import '../widgets/animated_fade_item.dart';
import '../widgets/result_list_view.dart';

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
              return const Center(
                child: CircularProgressIndicator(strokeWidth: 2),
              );
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
              return Center(
                child: Text(
                  "No saved lessons yet.",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).hintColor,
                  ),
                ),
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              SavedDetailScreen(savedSearch: item),
                        ),
                      );
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

class SavedDetailScreen extends StatelessWidget {
  final SavedSearch savedSearch;

  const SavedDetailScreen({super.key, required this.savedSearch});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          savedSearch.query.toUpperCase(),
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w400,
            fontSize: 22,
          ),
        ),
        scrolledUnderElevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: ResultListView(results: savedSearch.results),
        ),
      ),
    );
  }
}
