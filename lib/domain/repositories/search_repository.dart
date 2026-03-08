import '../models/search_result.dart';

abstract class SearchRepository {
  /// Fetches an organic list of search results for a given [query].
  Future<List<SearchResult>> fetchResults(String query);
}
