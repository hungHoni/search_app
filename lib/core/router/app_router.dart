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
import '../../presentation/screens/onboarding_screen.dart';
import '../../presentation/screens/settings_screen.dart';
import '../../presentation/screens/review_dashboard_screen.dart';
import '../../presentation/screens/paywall_screen.dart';

/// Creates a [CustomTransitionPage] with a combined fade + vertical slide
/// animation. Duration is 300ms with an easeOut curve for a premium feel.
CustomTransitionPage<void> _fadeSlideTransition({
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 300),
    reverseTransitionDuration: const Duration(milliseconds: 250),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final fadeAnimation = CurvedAnimation(
        parent: animation,
        curve: Curves.easeOut,
      );
      final slideAnimation = Tween<Offset>(
        begin: const Offset(0, 0.04), // Subtle 4% upward slide
        end: Offset.zero,
      ).animate(fadeAnimation);

      return FadeTransition(
        opacity: fadeAnimation,
        child: SlideTransition(position: slideAnimation, child: child),
      );
    },
  );
}

/// Provides standard routing for the application with Deep Linking support
/// and smooth page transition animations across all routes.
final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: <RouteBase>[
    // The entrypoint: AuthWrapper determines where the user goes
    GoRoute(
      path: '/',
      pageBuilder: (BuildContext context, GoRouterState state) {
        return _fadeSlideTransition(state: state, child: const AuthWrapper());
      },
    ),
    GoRoute(
      path: '/onboarding',
      pageBuilder: (BuildContext context, GoRouterState state) {
        return _fadeSlideTransition(
          state: state,
          child: const OnboardingScreen(),
        );
      },
    ),
    GoRoute(
      path: '/login',
      pageBuilder: (BuildContext context, GoRouterState state) {
        return _fadeSlideTransition(state: state, child: const AuthScreen());
      },
    ),
    GoRoute(
      path: '/signup',
      pageBuilder: (BuildContext context, GoRouterState state) {
        return _fadeSlideTransition(state: state, child: const SignupScreen());
      },
    ),
    // The main application screen. The 'q' param dictates if we show results or idle grid.
    GoRoute(
      path: '/search',
      pageBuilder: (BuildContext context, GoRouterState state) {
        final query = state.uri.queryParameters['q'];
        return _fadeSlideTransition(
          state: state,
          child: SearchScreen(initialQuery: query),
        );
      },
    ),
    GoRoute(
      path: '/bookmarks',
      pageBuilder: (BuildContext context, GoRouterState state) {
        return _fadeSlideTransition(
          state: state,
          child: const BookmarksScreen(),
        );
      },
      routes: [
        GoRoute(
          path: 'detail',
          pageBuilder: (BuildContext context, GoRouterState state) {
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
              return _fadeSlideTransition(
                state: state,
                child: const Scaffold(
                  body: Center(child: Text("Invalid Bookmark Data")),
                ),
              );
            }
            return _fadeSlideTransition(
              state: state,
              child: SavedDetailScreen(savedSearch: savedSearch),
            );
          },
        ),
      ],
    ),
    GoRoute(
      path: '/flashcards',
      pageBuilder: (BuildContext context, GoRouterState state) {
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
          return _fadeSlideTransition(
            state: state,
            child: const Scaffold(
              body: Center(child: Text("Invalid Flashcard Data")),
            ),
          );
        }
        return _fadeSlideTransition(
          state: state,
          child: FlashcardReviewScreen(flashcards: flashcards),
        );
      },
    ),
    GoRoute(
      path: '/paywall',
      pageBuilder: (BuildContext context, GoRouterState state) {
        final query = state.uri.queryParameters['q'] ?? '';
        return _fadeSlideTransition(
          state: state,
          child: PaywallScreen(attemptedQuery: query),
        );
      },
    ),
    GoRoute(
      path: '/settings',
      pageBuilder: (BuildContext context, GoRouterState state) {
        return _fadeSlideTransition(
          state: state,
          child: const SettingsScreen(),
        );
      },
    ),
    GoRoute(
      path: '/review',
      pageBuilder: (BuildContext context, GoRouterState state) {
        return _fadeSlideTransition(
          state: state,
          child: const ReviewDashboardScreen(),
        );
      },
    ),
  ],
  // Redirect guard to ensure unauthenticated users cannot access /search
  redirect: (BuildContext context, GoRouterState state) {
    final bool loggedIn = FirebaseAuth.instance.currentUser != null;
    final bool loggingIn =
        state.matchedLocation == '/login' || state.matchedLocation == '/signup';
    final bool onboarding = state.matchedLocation == '/onboarding';

    if (!loggedIn &&
        !loggingIn &&
        !onboarding &&
        state.matchedLocation != '/') {
      return '/login';
    }

    // AuthWrapper handles the / redirect, but if they try to hit /login while logged in:
    if (loggedIn && loggingIn) {
      return '/search';
    }

    return null;
  },
);
