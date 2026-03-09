import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:search_app/presentation/screens/flashcard_review_screen.dart';
import 'package:search_app/domain/models/flashcard.dart';

void main() {
  group('FlashcardReviewScreen Widget Test', () {
    testWidgets('Renders properly and flips card on tap to reveal answer', (
      WidgetTester tester,
    ) async {
      final flashcards = [
        const Flashcard(question: 'Test Question 1', answer: 'Test Answer 1'),
        const Flashcard(question: 'Test Question 2', answer: 'Test Answer 2'),
      ];

      await tester.pumpWidget(
        MaterialApp(home: FlashcardReviewScreen(flashcards: flashcards)),
      );

      // Verify the screen loads and displays the first question
      expect(find.text('Review Flashcards'), findsOneWidget);
      expect(find.text('Test Question 1'), findsOneWidget);

      // Answer should not be visible initially as the isFrontVisible boolean hides it
      expect(find.text('Test Answer 1'), findsNothing);

      // Tap the card to trigger the 3D flip animation
      await tester.tap(find.text('Test Question 1'));

      // Wait for the animation to fully complete
      await tester.pumpAndSettle();

      // Now the question should be hidden, and the answer should be visible
      expect(find.text('Test Question 1'), findsNothing);
      expect(find.text('Test Answer 1'), findsOneWidget);
    });
  });
}
