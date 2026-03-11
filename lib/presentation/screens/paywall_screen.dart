import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import '../widgets/animated_fade_item.dart';
import '../../infrastructure/purchase_service.dart';

class PaywallScreen extends StatefulWidget {
  final String attemptedQuery;

  const PaywallScreen({super.key, required this.attemptedQuery});

  @override
  State<PaywallScreen> createState() => _PaywallScreenState();
}

class _PaywallScreenState extends State<PaywallScreen> {
  bool _isLoading = false;

  void _handlePurchase() async {
    setState(() => _isLoading = true);
    final success = await PurchaseService().purchasePremium();
    if (mounted) {
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Purchase successful! Unlimited access unlocked.',
              style: GoogleFonts.inter(color: Colors.white),
            ),
            backgroundColor: const Color(0xFF222222),
            duration: const Duration(seconds: 2),
          ),
        );
        await Future.delayed(const Duration(seconds: 2));
        if (mounted) {
          setState(() => _isLoading = false);
          context.pop(true);
        }
      } else {
        setState(() => _isLoading = false);
      }
    }
  }

  void _handleRestore() async {
    setState(() => _isLoading = true);
    final success = await PurchaseService().restorePurchases();
    if (mounted) {
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Purchases restored! Unlimited access unlocked.',
              style: GoogleFonts.inter(color: Colors.white),
            ),
            backgroundColor: const Color(0xFF222222),
            duration: const Duration(seconds: 2),
          ),
        );
        await Future.delayed(const Duration(seconds: 2));
        if (mounted) {
          setState(() => _isLoading = false);
          context.pop(true);
        }
      } else {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No previous purchases found.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.pop(false),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 32.0,
                vertical: 24.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Spacer(),
                  AnimatedFadeItem(
                    delay: const Duration(milliseconds: 100),
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFF0F0F0),
                      ),
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.workspace_premium,
                        size: 40,
                        color: Color(0xFF222222),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  AnimatedFadeItem(
                    delay: const Duration(milliseconds: 200),
                    child: Text(
                      'Unlock\nInfinite Knowledge.',
                      style: GoogleFonts.lora(
                        fontSize: 40,
                        fontWeight: FontWeight.w400,
                        height: 1.1,
                        letterSpacing: -1.0,
                        color: const Color(0xFF222222),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  AnimatedFadeItem(
                    delay: const Duration(milliseconds: 300),
                    child: Text(
                      'You requested to deep-dive into "${widget.attemptedQuery}".\n\nTo search custom topics outside of the curated 100-keyword library, unlock Premium to access live AI generation forever.',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        height: 1.6,
                        color: const Color(0xFF555555),
                      ),
                    ),
                  ),
                  const SizedBox(height: 48),
                  AnimatedFadeItem(
                    delay: const Duration(milliseconds: 400),
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFFEAEAEA)),
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.check_circle,
                                color: Color(0xFF222222),
                                size: 20,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  "Unlimited custom searches",
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    color: const Color(0xFF333333),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              const Icon(
                                Icons.check_circle,
                                color: Color(0xFF222222),
                                size: 20,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  "Instant AI flashcard generation",
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    color: const Color(0xFF333333),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              const Icon(
                                Icons.check_circle,
                                color: Color(0xFF222222),
                                size: 20,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  "One-time payment, lifetime access",
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    color: const Color(0xFF333333),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(flex: 2),
                  if (_isLoading)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: CircularProgressIndicator(
                          color: Color(0xFF222222),
                        ),
                      ),
                    )
                  else
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ElevatedButton(
                          onPressed: _handlePurchase,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF222222),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'UNLOCK FOREVER - \$1.99',
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.0,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextButton(
                          onPressed: _handleRestore,
                          child: Text(
                            'Restore Purchases',
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              color: const Color(0xFF666666),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
