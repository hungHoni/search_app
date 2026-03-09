import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

import '../domain/models/search_result.dart';
import '../domain/repositories/search_repository.dart';

class GeminiSearchService implements SearchRepository {
  @override
  Future<List<SearchResult>> fetchResults(String query) async {
    final apiKey = dotenv.env['GEMINI_API_KEY'];
    if (apiKey == null ||
        apiKey.isEmpty ||
        apiKey == 'your_gemini_api_key_here') {
      throw Exception(
        'Oops! Please put your real Gemini API key inside the .env file in the project root, then do a Hot Restart.',
      );
    }

    final model = GenerativeModel(
      model: 'gemini-2.5-flash',
      apiKey: apiKey,
      generationConfig: GenerationConfig(responseMimeType: 'application/json'),
    );

    final prompt =
        '''
You are an expert technical educator. Provide a deep, 5-part educational analysis of the topic: "$query".
Return the result strictly as a JSON array of 5 objects. Each object must have exactly two string fields: "title" and "summary".

The titles must strictly follow this numbered structure:
1. The Core Concept
2. Key Components & Implementation
3. Time & Space Complexity
4. Common Pitfalls
5. Real-World Applications

The summary should be concise, highly educational, and 2-3 sentences max.
''';

    try {
      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);

      final String? responseText = response.text;
      if (responseText == null || responseText.isEmpty) {
        throw Exception('Received an empty response from Gemini.');
      }

      final List<dynamic> jsonList = jsonDecode(responseText);

      if (jsonList.length < 5) {
        throw Exception('Gemini did not return all 5 required parts.');
      }

      return jsonList.take(5).map((json) {
        return SearchResult(
          title: json['title'] ?? 'Unknown Title',
          summary: json['summary'] ?? 'No summary provided',
          url: '', // Unused in this minimal UI
        );
      }).toList();
    } catch (e) {
      if (e is FormatException) {
        throw Exception(
          'Gemini returned an invalid JSON block. Please try again.',
        );
      }
      throw Exception('Failed to fetch from Gemini: $e');
    }
  }
}
