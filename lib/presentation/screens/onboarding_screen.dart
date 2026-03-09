import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/animated_fade_item.dart';
import 'package:go_router/go_router.dart';

/// A cinematic, 3-screen onboarding flow shown only on first app launch.
/// Uses editorial typography, staggered fade animations, and a smooth
/// PageView transition to create a premium first impression.
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  static const _pages = [
    _OnboardingPage(
      headline: "Learn\nAnything.",
      subtitle:
          "Ask any technical question.\nGet a structured, 5-part deep analysis — instantly.",
      icon: Icons.auto_awesome,
    ),
    _OnboardingPage(
      headline: "Remember\nEverything.",
      subtitle:
          "Save lessons to your library.\nGenerate AI flashcards for active recall studying.",
      icon: Icons.style,
    ),
    _OnboardingPage(
      headline: "Export\nEverywhere.",
      subtitle:
          "One-tap Markdown export.\nPaste beautifully into Notion, Obsidian, or anywhere.",
      icon: Icons.copy_all,
    ),
  ];

  Future<void> _completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_complete', true);
    if (mounted) {
      context.go('/');
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _pages.length,
                onPageChanged: (index) {
                  setState(() => _currentPage = index);
                },
                itemBuilder: (context, index) {
                  return _OnboardingSlide(page: _pages[index]);
                },
              ),
            ),

            // Bottom Navigation
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Page Indicators
                  Row(
                    children: List.generate(
                      _pages.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOut,
                        margin: const EdgeInsets.only(right: 8),
                        width: _currentPage == index ? 32 : 8,
                        height: 4,
                        decoration: BoxDecoration(
                          color: _currentPage == index
                              ? const Color(0xFF222222)
                              : const Color(0xFFDDDDDD),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                  ),

                  // Next / Get Started button
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: _currentPage == _pages.length - 1
                        ? ElevatedButton(
                            key: const ValueKey('start'),
                            onPressed: _completeOnboarding,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF222222),
                              foregroundColor: Colors.white,
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 32,
                                vertical: 16,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            child: Text(
                              "GET STARTED",
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 2.0,
                                color: Colors.white,
                              ),
                            ),
                          )
                        : TextButton(
                            key: const ValueKey('next'),
                            onPressed: () {
                              _pageController.nextPage(
                                duration: const Duration(milliseconds: 400),
                                curve: Curves.easeInOut,
                              );
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "NEXT",
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 2.0,
                                    color: const Color(0xFF222222),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Icon(
                                  Icons.arrow_forward,
                                  size: 16,
                                  color: Color(0xFF222222),
                                ),
                              ],
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OnboardingPage {
  final String headline;
  final String subtitle;
  final IconData icon;

  const _OnboardingPage({
    required this.headline,
    required this.subtitle,
    required this.icon,
  });
}

class _OnboardingSlide extends StatelessWidget {
  final _OnboardingPage page;

  const _OnboardingSlide({required this.page});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon with subtle background
          AnimatedFadeItem(
            delay: const Duration(milliseconds: 100),
            child: Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(page.icon, size: 28, color: const Color(0xFF222222)),
            ),
          ),
          const SizedBox(height: 48),

          // Headline
          AnimatedFadeItem(
            delay: const Duration(milliseconds: 250),
            child: Text(
              page.headline,
              style: GoogleFonts.lora(
                fontSize: 56,
                fontWeight: FontWeight.w400,
                height: 1.05,
                letterSpacing: -2.0,
                color: const Color(0xFF222222),
              ),
            ),
          ),
          const SizedBox(height: 32),

          // Subtitle
          AnimatedFadeItem(
            delay: const Duration(milliseconds: 400),
            child: Text(
              page.subtitle,
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                height: 1.6,
                color: const Color(0xFF888888),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
