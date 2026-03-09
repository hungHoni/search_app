import 'search_result.dart';
import 'flashcard.dart';

class SavedSearch {
  final String id;
  final String query;
  final DateTime timestamp;
  final List<SearchResult> results;
  final List<Flashcard>? flashcards;

  SavedSearch({
    required this.id,
    required this.query,
    required this.timestamp,
    required this.results,
    this.flashcards,
  });

  Map<String, dynamic> toJson() {
    return {
      'query': query,
      'timestamp': timestamp.toIso8601String(),
      'results': results
          .map((e) => {'title': e.title, 'summary': e.summary, 'url': e.url})
          .toList(),
      if (flashcards != null)
        'flashcards': flashcards!.map((e) => e.toJson()).toList(),
    };
  }

  factory SavedSearch.fromJson(String id, Map<String, dynamic> json) {
    return SavedSearch(
      id: id,
      query: json['query'] ?? '',
      timestamp: DateTime.tryParse(json['timestamp'] ?? '') ?? DateTime.now(),
      results:
          (json['results'] as List<dynamic>?)?.map((e) {
            return SearchResult(
              title: e['title'] ?? '',
              summary: e['summary'] ?? '',
              url: e['url'] ?? '',
            );
          }).toList() ??
          [],
      flashcards: (json['flashcards'] as List<dynamic>?)?.map((e) {
        return Flashcard.fromJson(e as Map<String, dynamic>);
      }).toList(),
    );
  }
}
