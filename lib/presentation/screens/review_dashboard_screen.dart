import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/models/flashcard.dart';
import '../../infrastructure/firestore_bookmark_repository.dart';
import '../widgets/animated_fade_item.dart';

class ReviewDashboardScreen extends StatefulWidget {
  const ReviewDashboardScreen({super.key});

  @override
  State<ReviewDashboardScreen> createState() => _ReviewDashboardScreenState();
}

class _ReviewDashboardScreenState extends State<ReviewDashboardScreen> {
  final _bookmarkService = FirestoreBookmarkRepository();
  List<Flashcard> _allCards = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCards();
  }

  Future<void> _loadCards() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final cards = await _bookmarkService.getAllFlashcards(user.uid);
      if (mounted) {
        setState(() {
          _allCards = cards;
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF222222)),
          onPressed: () => context.pop(),
        ),
        title: Text(
          "SPACED REPETITION",
          style: GoogleFonts.inter(
            color: const Color(0xFF222222),
            fontSize: 14,
            fontWeight: FontWeight.w700,
            letterSpacing: 2.0,
          ),
        ),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(strokeWidth: 2))
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 48),
                  _buildStatsSection(),
                  const Spacer(),
                  _buildStartButton(),
                  const SizedBox(height: 32),
                ],
              ),
            ),
    );
  }

  Widget _buildHeader() {
    return AnimatedFadeItem(
      delay: const Duration(milliseconds: 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Master Your Knowledge",
            style: GoogleFonts.lora(fontSize: 28, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          Text(
            "Review flashcards from all your saved lessons to lock concepts into long-term memory.",
            style: GoogleFonts.inter(fontSize: 14, color: Colors.grey[600], height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsSection() {
    return AnimatedFadeItem(
      delay: const Duration(milliseconds: 200),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: const Color(0xFFF9F9F9),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFEEEEEE)),
        ),
        child: Row(
          children: [
            _buildStatItem("Total Cards", _allCards.length.toString()),
            Container(width: 1, height: 40, color: const Color(0xFFEEEEEE), margin: const EdgeInsets.symmetric(horizontal: 24)),
            _buildStatItem("Daily Goal", "10"),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w700, color: Colors.grey[500], letterSpacing: 1.0),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: GoogleFonts.lora(fontSize: 24, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  Widget _buildStartButton() {
    final bool hasCards = _allCards.isNotEmpty;

    return AnimatedFadeItem(
      delay: const Duration(milliseconds: 300),
      child: ElevatedButton(
        onPressed: hasCards
            ? () {
                HapticFeedback.mediumImpact();
                // Shuffle for the session
                final sessionCards = List<Flashcard>.from(_allCards)..shuffle();
                context.push('/flashcards', extra: sessionCards);
              }
            : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF222222),
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 64),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          disabledBackgroundColor: const Color(0xFFEEEEEE),
        ),
        child: Text(
          hasCards ? "START STUDY SESSION" : "NO CARDS SAVED YET",
          style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, letterSpacing: 1.5),
        ),
      ),
    );
  }
}
