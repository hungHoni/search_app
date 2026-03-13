import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../infrastructure/purchase_service.dart';
import '../../infrastructure/daily_limit_service.dart';
import '../widgets/animated_fade_item.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final user = FirebaseAuth.instance.currentUser;
  int _generationsLeft = 5;
  bool _isPremium = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadStatus();
  }

  Future<void> _loadStatus() async {
    final left = await DailyLimitService().getGenerationsLeft();
    final premium = PurchaseService().isPremium;
    if (mounted) {
      setState(() {
        _generationsLeft = left;
        _isPremium = premium;
        _isLoading = false;
      });
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
          "SETTINGS",
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
          : SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. Profile Section
                  _buildSectionHeader("ACCOUNT"),
                  const SizedBox(height: 16),
                  AnimatedFadeItem(
                    delay: const Duration(milliseconds: 100),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF9F9F9),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: const Color(0xFF222222),
                            radius: 24,
                            child: Text(
                              (user?.email ?? "U")[0].toUpperCase(),
                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  user?.email ?? "Anonymous User",
                                  style: GoogleFonts.lora(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  _isPremium ? "Premium Member" : "Free Tier",
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    color: _isPremium ? const Color(0xFF222222) : Colors.grey[600],
                                    fontWeight: _isPremium ? FontWeight.w700 : FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),

                  // 2. Usage Section
                  _buildSectionHeader("DAILY USAGE"),
                  const SizedBox(height: 16),
                  AnimatedFadeItem(
                    delay: const Duration(milliseconds: 200),
                    child: _buildUsageMeter(),
                  ),
                  const SizedBox(height: 40),

                  // 3. Actions Section
                  _buildSectionHeader("SYSTEM"),
                  const SizedBox(height: 16),
                  _buildSettingTile(
                    "Privacy Policy",
                    Icons.security_outlined,
                    () => _launchUrl("https://minimalstudy.app/privacy"),
                    delay: const Duration(milliseconds: 300),
                  ),
                  _buildSettingTile(
                    "Terms of Service",
                    Icons.description_outlined,
                    () => _launchUrl("https://minimalstudy.app/terms"),
                    delay: const Duration(milliseconds: 350),
                  ),
                  const SizedBox(height: 32),
                  
                  AnimatedFadeItem(
                    delay: const Duration(milliseconds: 450),
                    child: OutlinedButton(
                      onPressed: () async {
                        HapticFeedback.heavyImpact();
                        await FirebaseAuth.instance.signOut();
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFFEEEEEE)),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                      ),
                      child: Text(
                        "LOG OUT",
                        style: GoogleFonts.inter(
                          color: const Color(0xFF222222),
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: GoogleFonts.inter(
        fontSize: 11,
        fontWeight: FontWeight.w800,
        color: Colors.grey[500],
        letterSpacing: 1.5,
      ),
    );
  }

  Widget _buildUsageMeter() {
    final int used = 5 - _generationsLeft;
    final double percent = used / 5.0;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFEEEEEE)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "AI Generations",
                style: GoogleFonts.lora(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              Text(
                "$used / 5",
                style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: LinearProgressIndicator(
              value: percent,
              minHeight: 8,
              backgroundColor: const Color(0xFFEEEEEE),
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF222222)),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            _isPremium 
              ? "You have $_generationsLeft custom AI generations left today."
              : "Upgrade to use custom AI searches.",
            style: GoogleFonts.inter(fontSize: 12, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingTile(String title, IconData icon, VoidCallback onTap, {required Duration delay}) {
    return AnimatedFadeItem(
      delay: delay,
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Icon(icon, color: const Color(0xFF222222), size: 20),
        title: Text(
          title,
          style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w400),
        ),
        trailing: const Icon(Icons.chevron_right, size: 20, color: Color(0xFFEEEEEE)),
        onTap: () {
          HapticFeedback.lightImpact();
          onTap();
        },
      ),
    );
  }

  void _launchUrl(String url) {
    // In a real app, use url_launcher. For this prototype, we'll just log.
    debugPrint("Launching $url");
  }
}
