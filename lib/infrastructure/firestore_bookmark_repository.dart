import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../domain/models/saved_search.dart';
import '../domain/models/search_result.dart';
import '../domain/models/flashcard.dart';
import '../domain/repositories/bookmark_repository.dart';

class FirestoreBookmarkRepository implements BookmarkRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<void> saveSearch(
    String userId,
    String query,
    List<SearchResult> results,
  ) async {
    final docRef = _firestore
        .collection('users')
        .doc(userId)
        .collection('bookmarks')
        .doc();

    final savedSearch = SavedSearch(
      id: docRef.id,
      query: query,
      timestamp: DateTime.now(),
      results: results,
    );

    await docRef.set(savedSearch.toJson());
  }

  @override
  Future<void> updateSearch(SavedSearch search) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    await _firestore
        .collection('users')
        .doc(user.uid)
        .collection('bookmarks')
        .doc(search.id)
        .set(search.toJson(), SetOptions(merge: true));
  }

  @override
  Future<void> deleteSearch(String userId, String bookmarkId) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('bookmarks')
        .doc(bookmarkId)
        .delete();
  }

  @override
  Stream<List<SavedSearch>> watchSavedSearches(String userId) {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('bookmarks')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            return SavedSearch.fromJson(doc.id, doc.data());
          }).toList();
        });
  }

  @override
  Future<List<Flashcard>> getAllFlashcards(String userId) async {
    final snapshot = await _firestore
        .collection('users')
        .doc(userId)
        .collection('bookmarks')
        .get();

    final List<Flashcard> allCards = [];
    for (final doc in snapshot.docs) {
      final data = doc.data();
      if (data.containsKey('flashcards')) {
        final cardsJson = data['flashcards'] as List<dynamic>;
        for (final cardJson in cardsJson) {
          allCards.add(Flashcard.fromJson(cardJson as Map<String, dynamic>));
        }
      }
    }
    return allCards;
  }
}
