import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/animated_fade_item.dart';
import 'search_screen.dart';
import 'signup_screen.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator(strokeWidth: 2)),
          );
        }

        if (snapshot.hasData) {
          return const SearchScreen();
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
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submitAuth() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      setState(() => _errorMessage = 'Please enter email and password');
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errorMessage = e.message ?? 'An error occurred during authentication';
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'An unexpected error occurred';
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
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AnimatedFadeItem(
                  delay: const Duration(milliseconds: 100),
                  child: Text(
                    "Welcome\nBack.",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: 48,
                      height: 1.1,
                      fontWeight: FontWeight.w400,
                      letterSpacing: -1.5,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                const SizedBox(height: 64),

                // Email Field
                AnimatedFadeItem(
                  delay: const Duration(milliseconds: 250),
                  child: TextField(
                    controller: _emailController,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 24,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Email',
                      hintStyle: Theme.of(context).textTheme.titleLarge
                          ?.copyWith(
                            fontWeight: FontWeight.w300,
                            fontSize: 24,
                            color: Theme.of(context).hintColor,
                          ),
                      contentPadding: const EdgeInsets.only(bottom: 8),
                      isDense: true,
                      border: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFEEEEEE)),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFEEEEEE)),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    autocorrect: false,
                  ),
                ),
                const SizedBox(height: 32),

                // Password Field
                AnimatedFadeItem(
                  delay: const Duration(milliseconds: 400),
                  child: TextField(
                    controller: _passwordController,
                    obscureText: true,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 24,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle: Theme.of(context).textTheme.titleLarge
                          ?.copyWith(
                            fontWeight: FontWeight.w300,
                            fontSize: 24,
                            color: Theme.of(context).hintColor,
                          ),
                      contentPadding: const EdgeInsets.only(bottom: 8),
                      isDense: true,
                      border: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFEEEEEE)),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFEEEEEE)),
                      ),
                    ),
                    textInputAction: TextInputAction.done,
                    onSubmitted: (_) => _submitAuth(),
                  ),
                ),
                const SizedBox(height: 16),

                if (_errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Text(
                      _errorMessage!,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .primary, // Enforce strict monochrome palette
                      ),
                    ),
                  ),

                const SizedBox(height: 32),

                // Action Buttons
                AnimatedFadeItem(
                  delay: const Duration(milliseconds: 550),
                  child: _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ElevatedButton(
                              onPressed: _submitAuth,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(
                                  context,
                                ).colorScheme.primary,
                                foregroundColor: Theme.of(
                                  context,
                                ).colorScheme.onPrimary,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 20,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                elevation: 0,
                              ),
                              child: Text(
                                "LOG IN",
                                style: Theme.of(context).textTheme.labelSmall
                                    ?.copyWith(
                                      color: Colors.white,
                                      letterSpacing: 2.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SignupScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                "Need an account? Sign up",
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary
                                          .withValues(alpha: 0.7),
                                    ),
                              ),
                            ),
                          ],
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
