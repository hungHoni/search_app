import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';
import '../widgets/animated_fade_item.dart';
import 'splash_screen.dart';

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  bool _splashComplete = false;
  bool _checkingOnboarding = true;
  bool _onboardingDone = false;

  @override
  void initState() {
    super.initState();
    _checkOnboarding();
  }

  Future<void> _checkOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    final done = prefs.getBool('onboarding_complete') ?? false;
    if (mounted) {
      setState(() {
        _onboardingDone = done;
        _checkingOnboarding = false;
      });
    }
  }

  void _onSplashComplete() {
    if (mounted) {
      setState(() => _splashComplete = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_splashComplete) {
      return SplashScreen(onComplete: _onSplashComplete);
    }

    if (_checkingOnboarding) {
      return const Scaffold(body: SizedBox.shrink());
    }

    if (!_onboardingDone) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) context.go('/onboarding');
      });
      return const Scaffold(body: SizedBox.shrink());
    }

    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: SizedBox.shrink());
        }

        if (snapshot.hasData) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.go('/search');
          });
          return const Scaffold(body: SizedBox.shrink());
        }

        return const AuthScreen();
      },
    );
  }
}

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _signInWithGoogle() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      if (kIsWeb) {
        // Fallback for Web: authenticate() is not supported on Web in 7.x
        // We use FirebaseAuth's direct popup method which works perfectly on Chrome
        final GoogleAuthProvider googleProvider = GoogleAuthProvider();
        await FirebaseAuth.instance.signInWithPopup(googleProvider);
      } else {
        // Mobile flow
        final googleSignIn = GoogleSignIn.instance;

        // Initialize is required in 7.0.0+ before any other calls
        // serverClientId is needed on Android to obtain the idToken
        await googleSignIn.initialize(
          serverClientId: '204197319739-6g7uj24rh4u6m2fet5kar9r2sordsa5p.apps.googleusercontent.com',
        );
        
        // authenticate() replaces signIn() in 7.0.0+
        final googleUser = await googleSignIn.authenticate();

        // authentication is now a property, not a Future in 7.2.0
        final googleAuth = googleUser.authentication;
        
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: null, 
          idToken: googleAuth.idToken,
        );

        await FirebaseAuth.instance.signInWithCredential(credential);
      }
    } on FirebaseAuthException catch (e) {
      debugPrint('FirebaseAuthException: ${e.code} - ${e.message}');
      setState(() {
        _errorMessage = e.message ?? 'Authentication failed';
      });
    } catch (e) {
      debugPrint('Google Sign-In Error: $e');
      setState(() {
        _errorMessage = 'Error: $e';
      });
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(flex: 2),
              AnimatedFadeItem(
                delay: const Duration(milliseconds: 100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Minimal",
                      style: GoogleFonts.lora(
                        fontSize: 56,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF222222),
                        height: 0.9,
                      ),
                    ),
                    Text(
                      "Study.",
                      style: GoogleFonts.lora(
                        fontSize: 56,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF222222),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              AnimatedFadeItem(
                delay: const Duration(milliseconds: 300),
                child: Text(
                  "Your personalized learning library, powered by AI and simplicity.",
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    color: Colors.grey[600],
                    height: 1.6,
                  ),
                ),
              ),
              const Spacer(flex: 3),
              if (_errorMessage != null)
                AnimatedFadeItem(
                  delay: Duration.zero,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Text(
                      _errorMessage!,
                      style: GoogleFonts.inter(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              AnimatedFadeItem(
                delay: const Duration(milliseconds: 500),
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator(strokeWidth: 2))
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          OutlinedButton(
                            onPressed: _signInWithGoogle,
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Color(0xFFEEEEEE), width: 1.5),
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              backgroundColor: Colors.white,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.login, size: 22, color: Color(0xFF222222)),
                                const SizedBox(width: 16),
                                Text(
                                  "SIGN IN WITH GOOGLE",
                                  style: GoogleFonts.inter(
                                    color: const Color(0xFF222222),
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 1.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
              ),
              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }
}
