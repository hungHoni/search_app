import '../models/saved_search.dart';
import '../models/search_result.dart';

abstract class BookmarkRepository {
  Future<void> saveSearch(
    String userId,
    String query,
    List<SearchResult> results,
  );
  Future<void> updateSearch(SavedSearch search);
  Future<void> deleteSearch(String userId, String bookmarkId);
  Stream<List<SavedSearch>> watchSavedSearches(String userId);
}
