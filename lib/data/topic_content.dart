import 'topic_content_fundamentals.dart';
import 'topic_content_engineering.dart';
import 'topic_content_advanced.dart';
import '../domain/models/search_result.dart';

/// Provides pre-generated educational content for all 100 curated topics.
/// Content is organized across 3 category files for maintainability.
/// The lookup is case-insensitive and returns null for unknown topics.
class TopicContent {
  static final Map<String, List<Map<String, String>>> _all = {
    ...fundamentalsContent,
    ...engineeringContent,
    ...advancedContent,
  };

  /// Returns pre-generated [SearchResult] list for [topic], or null if not found.
  static List<SearchResult>? getResults(String topic) {
    final key = topic.toLowerCase().trim();
    final data = _all[key];
    if (data == null) return null;

    return data
        .map(
          (entry) => SearchResult(
            title: entry['title'] ?? '',
            summary: entry['summary'] ?? '',
            url: '',
          ),
        )
        .toList();
  }

  /// Whether we have pre-generated content for [topic].
  static bool hasContent(String topic) {
    return _all.containsKey(topic.toLowerCase().trim());
  }
}
