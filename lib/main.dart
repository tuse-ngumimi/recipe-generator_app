import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const CookdApp());
}

class CookdApp extends StatelessWidget {
  const CookdApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "COOK'd",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFF8C42), // Orange
          primary: const Color(0xFFFF8C42),
          secondary: const Color(0xFFFFF4E6), // Cream
          surface: const Color(0xFFFFF4E6),
        ),
        scaffoldBackgroundColor: const Color(0xFFFFFBF5),

        textTheme: TextTheme(
          // font for COOK'd title and main headers
          displayLarge: GoogleFonts.mynerve(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          displayMedium: GoogleFonts.mynerve(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: const Color(0xFFFF8C42),
          ),
          displaySmall: GoogleFonts.mynerve(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: const Color(0xFFFF8C42),
          ),
          // font for the section headers
          headlineMedium: GoogleFonts.mynerve(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: const Color(0xFFFF8C42),
          ),
          headlineSmall: GoogleFonts.mynerve(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          // font for the body text
          bodyLarge: GoogleFonts.poppins(
            fontSize: 16,
          ),
          bodyMedium: GoogleFonts.poppins(
            fontSize: 14,
          ),
          bodySmall: GoogleFonts.poppins(
            fontSize: 12,
          ),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: const Color(0xFFFF8C42),
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: GoogleFonts.mynerve(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFFFF8C42),
          foregroundColor: Colors.white,
        ),
        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFFF8C42)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFFFD4B8)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFFF8C42), width: 2),
          ),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}