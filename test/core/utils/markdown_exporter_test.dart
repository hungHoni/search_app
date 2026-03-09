import 'package:flutter_test/flutter_test.dart';
import 'package:search_app/core/utils/markdown_exporter.dart';
import 'package:search_app/domain/models/saved_search.dart';
import 'package:search_app/domain/models/search_result.dart';
import 'package:search_app/domain/models/flashcard.dart';

void main() {
  group('MarkdownExporter', () {
    test('exports search results properly when NO flashcards exist', () {
      final saved = SavedSearch(
        id: 'model-123',
        query: 'go_router basics',
        timestamp: DateTime(2026, 3, 9),
        results: [
          SearchResult(
            title: 'Routing Definition',
            summary: 'Use go_router for declarative routing.',
            url: '',
          ),
        ],
      );

      final result = MarkdownExporter.exportToNotion(saved);
      expect(result, contains('# GO_ROUTER BASICS'));
      expect(result, contains('### Routing Definition'));
      expect(result, contains('Use go_router for declarative routing.'));
      expect(result, isNot(contains('## Spaced Repetition (Flashcards)')));
    });

    test('exports search results inclusive of flashcards when present', () {
      final saved = SavedSearch(
        id: 'model-456',
        query: 'dart isolates',
        timestamp: DateTime(2026, 3, 9),
        results: [],
        flashcards: [
          const Flashcard(
            question: 'What is an isolate?',
            answer: 'A safe thread with isolated memory heap.',
          ),
        ],
      );

      final result = MarkdownExporter.exportToNotion(saved);
      expect(result, contains('## Spaced Repetition (Flashcards)'));
      expect(result, contains('**Q1: What is an isolate?**'));
      expect(result, contains('<details><summary>Reveal Answer</summary>'));
      expect(result, contains('> A safe thread with isolated memory heap.'));
    });
  });
}
