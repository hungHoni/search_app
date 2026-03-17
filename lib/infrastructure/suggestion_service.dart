import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';

/// Generates personalized "what to learn next" topic suggestions
/// based on the user's saved bookmark history, powered by Gemini via Cloud Function.
class SuggestionService {
  final HttpsCallable _geminiProxy =
      FirebaseFunctions.instance.httpsCallable('geminiProxy');

  /// Fetches the user's past search queries from Firestore,
  /// sends them to Gemini (via Cloud Function) for intelligent next-topic
  /// recommendations, and returns a list of suggestion strings.
  ///
  /// Returns an empty list if:
  /// - The user is not logged in
  /// - The user has no bookmarks yet
  /// - The Cloud Function call fails (caller should fall back to static pool)
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

      // 2. Ask Gemini for personalized next-topic suggestions via Cloud Function
      final response = await _geminiProxy.call<Map<String, dynamic>>({
        'type': 'suggestions',
        'contextData': pastTopics,
      });

      final data = response.data;
      final List<dynamic> results = List<dynamic>.from(data['results']);

      return results
          .map((item) => item.toString())
          .where((s) => s.isNotEmpty)
          .take(6)
          .toList();
    } catch (e) {
      // Silently fail — caller will fall back to static pool
      return [];
    }
  }
}
