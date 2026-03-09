import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// A premium branded splash screen that displays the app's typographic
/// logo with a smooth fade + scale animation over 800ms.
/// After the animation completes, it calls [onComplete] so the
/// caller can navigate to the next screen.
class SplashScreen extends StatefulWidget {
  final VoidCallback onComplete;

  const SplashScreen({super.key, required this.onComplete});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.92,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    // Start the animation after a brief pause to let the scaffold render
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) _controller.forward();
    });

    // After the full animation + a reading pause, trigger navigation
    Future.delayed(const Duration(milliseconds: 1600), () {
      if (mounted) widget.onComplete();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // App icon
                Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    color: const Color(0xFF222222),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: const Icon(
                    Icons.auto_awesome,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
                const SizedBox(height: 24),
                // Brand name
                Text(
                  "Minimal",
                  style: GoogleFonts.lora(
                    fontSize: 32,
                    fontWeight: FontWeight.w400,
                    letterSpacing: -1.0,
                    color: const Color(0xFF222222),
                  ),
                ),
                const SizedBox(height: 4),
                // Tagline
                Text(
                  "LEARN ANYTHING",
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 4.0,
                    color: const Color(0xFFAAAAAA),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
