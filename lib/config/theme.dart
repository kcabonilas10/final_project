import 'package:flutter/material.dart';  
import 'package:google_fonts/google_fonts.dart';  

class AppTheme {  
  // Light Theme  
  static ThemeData lightTheme = ThemeData(  
    useMaterial3: true,  
    brightness: Brightness.light,  
    colorScheme: ColorScheme.fromSeed(  
      seedColor: const Color(0xFF1E88E5), // Blue shade  
      brightness: Brightness.light,  
    ),  
    textTheme: GoogleFonts.poppinsTextTheme(ThemeData.light().textTheme),  
    
    // AppBar Theme  
    appBarTheme: AppBarTheme(  
      centerTitle: true,  
      elevation: 0,  
      backgroundColor: Colors.white,  
      iconTheme: const IconThemeData(color: Colors.black87),  
      titleTextStyle: GoogleFonts.poppins(  
        color: Colors.black87,  
        fontSize: 20,  
        fontWeight: FontWeight.w600,  
      ),  
    ),  
    
    // Button Theme  
    elevatedButtonTheme: ElevatedButtonThemeData(  
      style: ElevatedButton.styleFrom(  
        elevation: 2,  
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),  
        shape: RoundedRectangleBorder(  
          borderRadius: BorderRadius.circular(12),  
        ),  
      ),  
    ),  
    
    // Text Button Theme  
    textButtonTheme: TextButtonThemeData(  
      style: TextButton.styleFrom(  
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),  
        shape: RoundedRectangleBorder(  
          borderRadius: BorderRadius.circular(8),  
        ),  
      ),  
    ),  
    
    // Input Decoration Theme  
    inputDecorationTheme: InputDecorationTheme(  
      filled: true,  
      fillColor: Colors.grey.shade50,  
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),  
      border: OutlineInputBorder(  
        borderRadius: BorderRadius.circular(12),  
        borderSide: BorderSide(color: Colors.grey.shade200),  
      ),  
      enabledBorder: OutlineInputBorder(  
        borderRadius: BorderRadius.circular(12),  
        borderSide: BorderSide(color: Colors.grey.shade200),  
      ),  
      focusedBorder: OutlineInputBorder(  
        borderRadius: BorderRadius.circular(12),  
        borderSide: const BorderSide(color: Color(0xFF1E88E5), width: 2),  
      ),  
      errorBorder: OutlineInputBorder(  
        borderRadius: BorderRadius.circular(12),  
        borderSide: const BorderSide(color: Colors.red, width: 1),  
      ),  
      focusedErrorBorder: OutlineInputBorder(  
        borderRadius: BorderRadius.circular(12),  
        borderSide: const BorderSide(color: Colors.red, width: 2),  
      ),  
      labelStyle: const TextStyle(color: Colors.grey),  
      hintStyle: TextStyle(color: Colors.grey.shade400),  
    ),  
    
    // Card Theme  
    cardTheme: CardTheme(  
      elevation: 2,  
      shape: RoundedRectangleBorder(  
        borderRadius: BorderRadius.circular(16),  
      ),  
      color: Colors.white,  
    ),  
    
    // List Tile Theme  
    listTileTheme: const ListTileThemeData(  
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),  
      minLeadingWidth: 0,  
      horizontalTitleGap: 16,  
    ),  
    
    // Floating Action Button Theme  
    floatingActionButtonTheme: FloatingActionButtonThemeData(  
      elevation: 4,  
      shape: RoundedRectangleBorder(  
        borderRadius: BorderRadius.circular(16),  
      ),  
    ),  
  );  

  // Dark Theme  
  static ThemeData darkTheme = ThemeData(  
    useMaterial3: true,  
    brightness: Brightness.dark,  
    colorScheme: ColorScheme.fromSeed(  
      seedColor: const Color(0xFF1E88E5),  
      brightness: Brightness.dark,  
    ),  
    textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),  
    
    // AppBar Theme  
    appBarTheme: AppBarTheme(  
      centerTitle: true,  
      elevation: 0,  
      backgroundColor: const Color(0xFF1F1F1F),  
      titleTextStyle: GoogleFonts.poppins(  
        color: Colors.white,  
        fontSize: 20,  
        fontWeight: FontWeight.w600,  
      ),  
    ),  
    
    // Button Theme  
    elevatedButtonTheme: ElevatedButtonThemeData(  
      style: ElevatedButton.styleFrom(  
        elevation: 2,  
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),  
        shape: RoundedRectangleBorder(  
          borderRadius: BorderRadius.circular(12),  
        ),  
      ),  
    ),  
    
    // Text Button Theme  
    textButtonTheme: TextButtonThemeData(  
      style: TextButton.styleFrom(  
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),  
        shape: RoundedRectangleBorder(  
          borderRadius: BorderRadius.circular(8),  
        ),  
      ),  
    ),  
    
    // Input Decoration Theme  
    inputDecorationTheme: InputDecorationTheme(  
      filled: true,  
      fillColor: const Color(0xFF2C2C2C),  
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),  
      border: OutlineInputBorder(  
        borderRadius: BorderRadius.circular(12),  
        borderSide: const BorderSide(color: Color(0xFF3C3C3C)),  
      ),  
      enabledBorder: OutlineInputBorder(  
        borderRadius: BorderRadius.circular(12),  
        borderSide: const BorderSide(color: Color(0xFF3C3C3C)),  
      ),  
      focusedBorder: OutlineInputBorder(  
        borderRadius: BorderRadius.circular(12),  
        borderSide: const BorderSide(color: Color(0xFF1E88E5), width: 2),  
      ),  
      errorBorder: OutlineInputBorder(  
        borderRadius: BorderRadius.circular(12),  
        borderSide: const BorderSide(color: Colors.red, width: 1),  
      ),  
      focusedErrorBorder: OutlineInputBorder(  
        borderRadius: BorderRadius.circular(12),  
        borderSide: const BorderSide(color: Colors.red, width: 2),  
      ),  
      labelStyle: const TextStyle(color: Colors.grey),  
      hintStyle: const TextStyle(color: Color(0xFF6C6C6C)),  
    ),  
    
    // Card Theme  
    cardTheme: CardTheme(  
      elevation: 2,  
      shape: RoundedRectangleBorder(  
        borderRadius: BorderRadius.circular(16),  
      ),  
      color: const Color(0xFF2C2C2C),  
    ),  
    
    // List Tile Theme  
    listTileTheme: const ListTileThemeData(  
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),  
      minLeadingWidth: 0,  
      horizontalTitleGap: 16,  
    ),  
    
    // Floating Action Button Theme  
    floatingActionButtonTheme: FloatingActionButtonThemeData(  
      elevation: 4,  
      shape: RoundedRectangleBorder(  
        borderRadius: BorderRadius.circular(16),  
      ),  
    ),  
    
    // Scaffold Background Color  
    scaffoldBackgroundColor: const Color(0xFF1F1F1F),  
  );  
}