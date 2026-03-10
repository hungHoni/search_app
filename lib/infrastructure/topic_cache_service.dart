import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../domain/models/search_result.dart';

/// Provides a persistent local cache for topic search results.
/// Uses `shared_preferences` (which maps to localStorage on web)
/// to store serialized [SearchResult] lists keyed by topic name.
///
/// This allows previously-searched topics (or pre-seeded content)
/// to be displayed instantly without an API call.
class TopicCacheService {
  static const String _cachePrefix = 'topic_cache_';

  /// Returns cached [SearchResult] list for the given [topic],
  /// or null if no cache exists.
  Future<List<SearchResult>?> getCachedResults(String topic) async {
    final prefs = await SharedPreferences.getInstance();
    final key = _cachePrefix + topic.toLowerCase().trim();
    final jsonString = prefs.getString(key);

    if (jsonString == null) return null;

    try {
      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList.map((json) {
        return SearchResult(
          title: json['title'] ?? '',
          summary: json['summary'] ?? '',
          url: json['url'] ?? '',
        );
      }).toList();
    } catch (_) {
      return null;
    }
  }

  /// Saves [SearchResult] list to local cache for the given [topic].
  Future<void> cacheResults(String topic, List<SearchResult> results) async {
    final prefs = await SharedPreferences.getInstance();
    final key = _cachePrefix + topic.toLowerCase().trim();

    final jsonList = results
        .map((r) => {'title': r.title, 'summary': r.summary, 'url': r.url})
        .toList();

    await prefs.setString(key, jsonEncode(jsonList));
  }

  /// Checks if the given [topic] has cached content.
  Future<bool> hasCachedResults(String topic) async {
    final prefs = await SharedPreferences.getInstance();
    final key = _cachePrefix + topic.toLowerCase().trim();
    return prefs.containsKey(key);
  }
}
