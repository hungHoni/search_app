import 'package:flutter_test/flutter_test.dart';
import 'package:search_app/domain/models/saved_search.dart';
import 'package:search_app/domain/models/search_result.dart';
import 'package:search_app/domain/models/flashcard.dart';

void main() {
  group('SavedSearch', () {
    test('toJson and fromJson serialize complex Nested Objects correctly', () {
      final saved = SavedSearch(
        id: '123',
        query: 'search query',
        timestamp: DateTime(2026, 3, 9),
        results: [SearchResult(title: 'T', summary: 'S', url: '')],
        flashcards: [const Flashcard(question: 'Q', answer: 'A')],
      );

      final json = saved.toJson();
      final cloned = SavedSearch.fromJson('123', json);

      expect(cloned.id, '123');
      expect(cloned.query, 'search query');
      expect(cloned.results.length, 1);
      expect(cloned.results.first.title, 'T');
      expect(cloned.flashcards!.length, 1);
      expect(cloned.flashcards!.first.question, 'Q');
    });

    test('toJson gracefully omits flashcards if null', () {
      final saved = SavedSearch(
        id: '123',
        query: 'search query',
        timestamp: DateTime(2026, 3, 9),
        results: [],
      );

      final json = saved.toJson();
      expect(json.containsKey('flashcards'), isFalse);
    });
  });
}
