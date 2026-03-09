import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'dart:convert';

/// Generates personalized "what to learn next" topic suggestions
/// based on the user's saved bookmark history, powered by Gemini.
class SuggestionService {
  /// Fetches the user's past search queries from Firestore,
  /// sends them to Gemini for intelligent next-topic recommendations,
  /// and returns a list of suggestion strings.
  ///
  /// Returns an empty list if:
  /// - The user is not logged in
  /// - The user has no bookmarks yet
  /// - The Gemini API call fails (caller should fall back to static pool)
  Future<List<String>> generatePersonalizedSuggestions() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return [];

      // 1. Fetch the user's past saved topics from Firestore
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('bookmarks')
          .orderBy('timestamp', descending: true)
          .limit(10) // Use the 10 most recent topics as context
          .get();

      if (snapshot.docs.isEmpty) return [];

      final pastTopics = snapshot.docs
          .map((doc) => doc.data()['query']?.toString() ?? '')
          .where((q) => q.isNotEmpty)
          .toList();

      if (pastTopics.isEmpty) return [];

      // 2. Ask Gemini for personalized next-topic suggestions
      final apiKey = dotenv.env['GEMINI_API_KEY'] ?? '';
      if (apiKey.isEmpty) return [];

      final model = GenerativeModel(model: 'gemini-2.0-flash', apiKey: apiKey);

      final prompt =
          '''
You are an educational curriculum advisor. The user has previously studied these topics:

${pastTopics.map((t) => '- $t').join('\n')}

Based on their learning history, suggest exactly 6 new topics they should study next. 
The suggestions should:
- Build naturally on what they've already learned
- Progress from foundational to advanced
- Cover related but unexplored areas
- Be concise (2-4 words each)

Return ONLY a valid JSON array of 6 strings. No markdown, no explanation.
Example: ["Neural Networks", "Database Indexing", "CI/CD Pipelines", "WebSocket APIs", "Kubernetes Basics", "OAuth 2.0"]
''';

      final response = await model.generateContent([Content.text(prompt)]);
      final rawText = response.text?.trim() ?? '';

      // 3. Parse the JSON response
      // Strip markdown code fences if present
      String cleanJson = rawText;
      if (cleanJson.startsWith('```')) {
        cleanJson = cleanJson.replaceAll(RegExp(r'```\w*\n?'), '').trim();
      }

      final decoded = jsonDecode(cleanJson);
      if (decoded is List) {
        return decoded
            .map((item) => item.toString())
            .where((s) => s.isNotEmpty)
            .take(6)
            .toList();
      }

      return [];
    } catch (e) {
      // Silently fail — caller will fall back to static pool
      return [];
    }
  }
}
