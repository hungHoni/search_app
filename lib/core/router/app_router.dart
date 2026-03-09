import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../presentation/screens/auth_screen.dart';
import '../../presentation/screens/signup_screen.dart';
import '../../presentation/screens/search_screen.dart';
import '../../presentation/screens/bookmarks_screen.dart';
import '../../domain/models/saved_search.dart';
import '../../domain/models/flashcard.dart';
import '../../presentation/screens/flashcard_review_screen.dart';

// Provides standard routing for the application with Deep Linking support
final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: <RouteBase>[
    // The entrypoint: AuthWrapper determines where the user goes
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const AuthWrapper();
      },
    ),
    GoRoute(
      path: '/login',
      builder: (BuildContext context, GoRouterState state) {
        return const AuthScreen();
      },
    ),
    GoRoute(
      path: '/signup',
      builder: (BuildContext context, GoRouterState state) {
        return const SignupScreen();
      },
    ),
    // The main application screen. The 'q' param dictates if we show results or idle grid.
    GoRoute(
      path: '/search',
      builder: (BuildContext context, GoRouterState state) {
        final query = state.uri.queryParameters['q'];
        return SearchScreen(initialQuery: query);
      },
    ),
    GoRoute(
      path: '/bookmarks',
      builder: (BuildContext context, GoRouterState state) {
        return const BookmarksScreen();
      },
      routes: [
        GoRoute(
          path: 'detail',
          builder: (BuildContext context, GoRouterState state) {
            SavedSearch? savedSearch;
            if (state.extra is SavedSearch) {
              savedSearch = state.extra as SavedSearch;
            } else if (state.extra is Map<String, dynamic>) {
              final map = state.extra as Map<String, dynamic>;
              savedSearch = SavedSearch.fromJson(
                map['id']?.toString() ?? '',
                map,
              );
            }
            if (savedSearch == null) {
              return const Scaffold(
                body: Center(child: Text("Invalid Bookmark Data")),
              );
            }
            return SavedDetailScreen(savedSearch: savedSearch);
          },
        ),
      ],
    ),
    GoRoute(
      path: '/flashcards',
      builder: (BuildContext context, GoRouterState state) {
        List<Flashcard>? flashcards;
        if (state.extra is List) {
          final list = state.extra as List;
          flashcards = list.map((item) {
            if (item is Flashcard) return item;
            if (item is Map<String, dynamic>) return Flashcard.fromJson(item);
            return const Flashcard(question: 'Error', answer: 'Invalid data');
          }).toList();
        }
        if (flashcards == null || flashcards.isEmpty) {
          return const Scaffold(
            body: Center(child: Text("Invalid Flashcard Data")),
          );
        }
        return FlashcardReviewScreen(flashcards: flashcards);
      },
    ),
  ],
  // Optional: Add a redirect guard to ensure unauthenticated users cannot access /search
  redirect: (BuildContext context, GoRouterState state) {
    final bool loggedIn = FirebaseAuth.instance.currentUser != null;
    final bool loggingIn =
        state.matchedLocation == '/login' || state.matchedLocation == '/signup';

    if (!loggedIn && !loggingIn && state.matchedLocation != '/') {
      return '/login';
    }

    // AuthWrapper handles the / redirect, but if they try to hit /login while logged in:
    if (loggedIn && loggingIn) {
      return '/search';
    }

    return null;
  },
);
