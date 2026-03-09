import 'package:flutter_test/flutter_test.dart';
import 'package:search_app/domain/models/flashcard.dart';

void main() {
  group('Flashcard', () {
    test('toJson and fromJson preserve data perfectly', () {
      const card = Flashcard(
        question: 'What is a Widget?',
        answer: 'An immutable UI description.',
      );
      final json = card.toJson();

      expect(json, {
        'question': 'What is a Widget?',
        'answer': 'An immutable UI description.',
      });

      final cloned = Flashcard.fromJson(json);
      expect(cloned.question, 'What is a Widget?');
      expect(cloned.answer, 'An immutable UI description.');
    });

    test(
      'fromJson handles corrupted or missing JSON keys gracefully without crashing',
      () {
        final json = <String, dynamic>{};
        final card = Flashcard.fromJson(json);

        expect(card.question, 'Error: Missing question');
        expect(card.answer, 'Error: Missing answer');
      },
    );
  });
}
