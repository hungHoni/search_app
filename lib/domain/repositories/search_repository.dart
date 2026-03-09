import '../models/search_result.dart';
import '../models/flashcard.dart';

abstract class SearchRepository {
  /// Fetches an organic list of search results for a given [query].
  /// Fetches an organic list of search results for a given [query].
  Future<List<SearchResult>> fetchResults(String query);

  /// Generates a list of Q&A flashcards based on a topic and context payload.
  Future<List<Flashcard>> generateFlashcards(
    String topic,
    List<SearchResult> context,
  );
}
