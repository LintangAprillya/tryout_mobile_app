import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// App Constants
class AppConstants {
  // App Info
  static const String appName = 'Tryout Apps';
  static const String appVersion = '1.0.0';
  
  // API Configuration
  static const String baseUrl = 'https://api.example.com'; // Ganti dengan URL API Anda
  static const String apiVersion = 'v1';
  
  // Timeout
  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  
  // Local Storage Keys
  static const String keyIsLoggedIn = 'is_logged_in';
  static const String keyUserId = 'user_id';
  static const String keyUserName = 'user_name';
  static const String keyUserEmail = 'user_email';
  static const String keyAuthToken = 'auth_token';
  
  // Database
  static const String dbName = 'tryout_database.db';
  static const int dbVersion = 1;
  
  // Exam Settings
  static const int defaultExamDuration = 90; // menit
  static const int questionsPerPage = 1;
  static const bool autoSubmitOnTimeout = true;
}

/// App Colors
class AppColors {
  // Primary Colors - Figma Blue (#2260FF)
  static const Color primary = Color(0xFF2260FF);
  static const Color primaryDark = Color(0xFF1A4DCC);
  static const Color primaryLight = Color(0xFFB3C9FF);
  
  // Accent Colors
  static const Color accent = Color(0xFFFF9800);
  static const Color accentDark = Color(0xFFF57C00);
  static const Color accentLight = Color(0xFFFFE0B2);
  
  // Status Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFFC107);
  static const Color error = Color(0xFFF44336);
  static const Color info = Color(0xFF2260FF); // Match primary
  
  // Text Colors
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textHint = Color(0xFF9E9E9E);
  static const Color textWhite = Color(0xFFFFFFFF);
  
  // Background Colors
  static const Color background = Color(0xFFF5F5F5);
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color divider = Color(0xFFE0E0E0);
  static const Color border = Color(0xFFE0E0E0);
}

/// App Text Styles - League Spartan Font
class AppTextStyles {
  // Base text theme getter (untuk digunakan dengan Google Fonts)
  static TextTheme get textTheme => GoogleFonts.leagueSpartanTextTheme();
  
  // Headings
  static TextStyle heading1 = GoogleFonts.leagueSpartan(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    height: 1.2,
  );
  
  static TextStyle heading2 = GoogleFonts.leagueSpartan(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    height: 1.3,
  );
  
  static TextStyle heading3 = GoogleFonts.leagueSpartan(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.4,
  );
  
  // Body Text
  static TextStyle bodyLarge = GoogleFonts.leagueSpartan(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
    height: 1.5,
  );
  
  static TextStyle bodyMedium = GoogleFonts.leagueSpartan(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
    height: 1.5,
  );
  
  static TextStyle bodySmall = GoogleFonts.leagueSpartan(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
    height: 1.5,
  );
  
  // Button Text
  static TextStyle button = GoogleFonts.leagueSpartan(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textWhite,
    letterSpacing: 0.5,
  );
  
  // Caption
  static TextStyle caption = GoogleFonts.leagueSpartan(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.textHint,
    height: 1.5,
  );
}

/// App Spacing
class AppSpacing {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;
}

/// App Border Radius
class AppRadius {
  static const double sm = 4.0;
  static const double md = 8.0;
  static const double lg = 12.0;
  static const double xl = 16.0;
  static const double round = 999.0;
}
