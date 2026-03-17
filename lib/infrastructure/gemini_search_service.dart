import 'package:cloud_functions/cloud_functions.dart';

import '../domain/models/search_result.dart';
import '../domain/models/flashcard.dart';
import '../domain/repositories/search_repository.dart';

class GeminiSearchService implements SearchRepository {
  final HttpsCallable _geminiProxy =
      FirebaseFunctions.instance.httpsCallable('geminiProxy');

  @override
  Future<List<SearchResult>> fetchResults(String query) async {
    try {
      final response = await _geminiProxy.call<Map<String, dynamic>>({
        'query': query,
        'type': 'search',
      });

      final data = response.data;
      final List<dynamic> jsonList = List<dynamic>.from(data['results']);

      if (jsonList.length < 5) {
        throw Exception('Gemini did not return all 5 required parts.');
      }

      return jsonList.take(5).map((json) {
        return SearchResult(
          title: json['title'] ?? 'Unknown Title',
          summary: json['summary'] ?? 'No summary provided',
          url: '',
        );
      }).toList();
    } on FirebaseFunctionsException catch (e) {
      throw Exception('Cloud Function error: ${e.message}');
    } catch (e) {
      throw Exception('Failed to fetch from Gemini: $e');
    }
  }

  @override
  Future<List<Flashcard>> generateFlashcards(
    String topic,
    List<SearchResult> contextData,
  ) async {
    try {
      final response = await _geminiProxy.call<Map<String, dynamic>>({
        'query': topic,
        'type': 'flashcards',
        'contextData': contextData
            .map((c) => {'title': c.title, 'summary': c.summary})
            .toList(),
      });

      final data = response.data;
      final List<dynamic> jsonList = List<dynamic>.from(data['results']);

      if (jsonList.length < 5) {
        throw Exception('Gemini did not return all 5 required flashcards.');
      }

      return jsonList.take(5).map((json) {
        return Flashcard.fromJson(json as Map<String, dynamic>);
      }).toList();
    } on FirebaseFunctionsException catch (e) {
      throw Exception('Cloud Function error: ${e.message}');
    } catch (e) {
      throw Exception('Failed to generate flashcards: $e');
    }
  }
}
