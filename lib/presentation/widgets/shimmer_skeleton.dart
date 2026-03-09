import 'package:flutter/material.dart';

/// A premium shimmer skeleton loading widget. Replaces the generic
/// `CircularProgressIndicator` with an animated, pulsing gray bar pattern
/// that mimics the shape of the content being loaded — creating a
/// perception of speed and intentionality.
class ShimmerSkeleton extends StatefulWidget {
  /// Number of skeleton rows to display.
  final int lines;

  const ShimmerSkeleton({super.key, this.lines = 5});

  @override
  State<ShimmerSkeleton> createState() => _ShimmerSkeletonState();
}

class _ShimmerSkeletonState extends State<ShimmerSkeleton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final opacity = 0.04 + (_animation.value * 0.08); // Range: 0.04 to 0.12

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(widget.lines, (index) {
              // Stagger the entrance with slight delays per row
              final delay = index * 80;

              return TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: Duration(milliseconds: 400 + delay),
                curve: Curves.easeOut,
                builder: (context, value, child) {
                  return Opacity(
                    opacity: value,
                    child: Transform.translate(
                      offset: Offset(0, 12 * (1 - value)),
                      child: child,
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title skeleton bar
                      Container(
                        height: 18,
                        width: _titleWidth(index),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: opacity + 0.03),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Body skeleton bar
                      Container(
                        height: 12,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: opacity),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        height: 12,
                        width: _bodyWidth(index),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: opacity),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        );
      },
    );
  }

  /// Creates visually interesting asymmetric title widths.
  double _titleWidth(int index) {
    const widths = [180.0, 220.0, 160.0, 200.0, 140.0];
    return widths[index % widths.length];
  }

  /// Creates visually interesting asymmetric body widths.
  double _bodyWidth(int index) {
    const widths = [280.0, 240.0, 300.0, 200.0, 260.0];
    return widths[index % widths.length];
  }
}
