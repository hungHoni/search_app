import 'dart:math';
import 'package:flutter/material.dart';
import '../../domain/models/flashcard.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/animated_fade_item.dart';


class FlashcardReviewScreen extends StatefulWidget {
  final List<Flashcard> flashcards;

  const FlashcardReviewScreen({super.key, required this.flashcards});

  @override
  State<FlashcardReviewScreen> createState() => _FlashcardReviewScreenState();
}

class _FlashcardReviewScreenState extends State<FlashcardReviewScreen> {
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Review Flashcards",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w400,
            fontSize: 22,
          ),
        ),
        scrolledUnderElevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: widget.flashcards.length + 1, // Add 1 for completion page
                itemBuilder: (context, index) {
                  if (index == widget.flashcards.length) {
                    return _buildCompletionPage();
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32.0,
                      vertical: 16.0,
                    ),
                    child: FlipCardWidget(flashcard: widget.flashcards[index]),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: AnimatedFadeItem(
                delay: const Duration(milliseconds: 500),
                child: Text(
                  _pageController.hasClients && _pageController.page?.round() == widget.flashcards.length
                      ? "Great job!"
                      : "Swipe to navigate • Tap to flip",
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.5,
                    color: const Color(0xFF888888),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompletionPage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedFadeItem(
              delay: const Duration(milliseconds: 100),
              child: const Icon(Icons.celebration_outlined, size: 80, color: Color(0xFF222222)),
            ),
            const SizedBox(height: 32),
            AnimatedFadeItem(
              delay: const Duration(milliseconds: 200),
              child: Text(
                "Session Complete!",
                style: GoogleFonts.lora(
                  color: const Color(0xFF222222),
                  fontWeight: FontWeight.w500,
                  fontSize: 32,
                ),
              ),
            ),
            const SizedBox(height: 16),
            AnimatedFadeItem(
              delay: const Duration(milliseconds: 300),
              child: Text(
                "You reviewed ${widget.flashcards.length} cards today. Keep up the momentum!",
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  color: Colors.grey[600],
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
            ),
            const SizedBox(height: 48),
            AnimatedFadeItem(
              delay: const Duration(milliseconds: 500),
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF222222),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(200, 56),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: Text(
                  "FINISH",
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.5,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FlipCardWidget extends StatefulWidget {
  final Flashcard flashcard;

  const FlipCardWidget({super.key, required this.flashcard});

  @override
  State<FlipCardWidget> createState() => _FlipCardWidgetState();
}

class _FlipCardWidgetState extends State<FlipCardWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isFront = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _flipCard() {
    if (_controller.isAnimating) return;
    if (_isFront) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    _isFront = !_isFront;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _flipCard,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final value = _controller.value;
          final angle = value * pi; // 0 to 180 degrees

          bool isFrontVisible = angle <= pi / 2;
          final displayAngle = isFrontVisible ? angle : angle + pi;
          // Add pi to flip the mirror effect on the back side

          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001) // perspective
              ..rotateY(displayAngle),
            child: isFrontVisible ? _buildFront() : _buildBack(),
          );
        },
      ),
    );
  }

  Widget _buildFront() {
    return _buildCardContent(
      title: "QUESTION",
      content: widget.flashcard.question,
      color: Colors.white,
      textColor: Colors.black,
      borderColor: const Color(0xFFEEEEEE),
    );
  }

  Widget _buildBack() {
    return _buildCardContent(
      title: "ANSWER",
      content: widget.flashcard.answer,
      color: Theme.of(context).colorScheme.primary, // Black
      textColor: Colors.white,
      borderColor: Colors.transparent,
    );
  }

  Widget _buildCardContent({
    required String title,
    required String content,
    required Color color,
    required Color textColor,
    required Color borderColor,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          width: double.infinity,
          constraints: BoxConstraints(maxHeight: constraints.maxHeight),
          padding: const EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: borderColor),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: textColor.withValues(alpha: 0.5),
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              Flexible(
                child: SingleChildScrollView(
                  child: Text(
                    content,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: textColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
