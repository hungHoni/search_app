import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/animated_fade_item.dart';

/// A premium, editorial-style empty state widget that displays a message
/// with an icon and optional action button. Follows the strict monochromatic
/// aesthetic with staggered entrance animations.
class EmptyStateView extends StatelessWidget {
  final IconData icon;
  final String headline;
  final String subtitle;
  final String? actionLabel;
  final VoidCallback? onAction;

  const EmptyStateView({
    super.key,
    required this.icon,
    required this.headline,
    required this.subtitle,
    this.actionLabel,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon container with subtle bg
            AnimatedFadeItem(
              delay: const Duration(milliseconds: 100),
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(icon, size: 32, color: const Color(0xFFBBBBBB)),
              ),
            ),
            const SizedBox(height: 32),

            // Headline
            AnimatedFadeItem(
              delay: const Duration(milliseconds: 250),
              child: Text(
                headline,
                style: GoogleFonts.lora(
                  fontSize: 28,
                  fontWeight: FontWeight.w400,
                  letterSpacing: -0.5,
                  color: const Color(0xFF222222),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 12),

            // Subtitle
            AnimatedFadeItem(
              delay: const Duration(milliseconds: 400),
              child: Text(
                subtitle,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  height: 1.6,
                  color: const Color(0xFF999999),
                ),
                textAlign: TextAlign.center,
              ),
            ),

            // Optional CTA
            if (actionLabel != null && onAction != null) ...[
              const SizedBox(height: 32),
              AnimatedFadeItem(
                delay: const Duration(milliseconds: 550),
                child: TextButton(
                  onPressed: onAction,
                  child: Text(
                    actionLabel!,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 2.0,
                      color: const Color(0xFF222222),
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
