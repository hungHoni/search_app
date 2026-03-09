import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'core/router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await dotenv.load(fileName: ".env");
  runApp(const MinimalSearchApp());
}

class MinimalSearchApp extends StatelessWidget {
  const MinimalSearchApp({super.key});

  @override
  Widget build(BuildContext context) {
    final baseTextTheme = Theme.of(context).textTheme;

    return MaterialApp.router(
      routerConfig: appRouter,
      title: 'Minimal Search',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light, // Forced Light Mode
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF222222), // Charcoal black
          onPrimary: Colors.white,
          surface: Colors.white,
          onSurface: Color(0xFF444444),
        ),
        textTheme: GoogleFonts.loraTextTheme(baseTextTheme).copyWith(
          bodyLarge: GoogleFonts.lora(
            color: const Color(0xFF333333),
            fontSize: 18,
          ),
          bodyMedium: GoogleFonts.lora(
            color: const Color(0xFF555555),
            fontSize: 16,
          ),
          titleLarge: GoogleFonts.lora(
            color: const Color(0xFF222222),
            fontSize: 22,
            fontWeight: FontWeight.w500,
            height: 1.4,
          ),
          labelSmall: GoogleFonts.inter(
            color: const Color(0xFF888888),
            fontSize: 11,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.5,
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          hintStyle: TextStyle(color: Colors.black26), // Even softer hint text
        ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.black54,
          selectionColor: Colors.black12,
          selectionHandleColor: Colors.black54,
        ),
        useMaterial3: true,
      ),
    );
  }
}
