// lib/main.dart  
import 'package:flutter/material.dart';  
import 'package:provider/provider.dart';  
import 'providers/cart_provider.dart';  
import 'providers/auth_provider.dart';  
import 'screens/auth/verification_screen.dart';  
import 'screens/home_screen.dart';  
import 'screens/cart_screen.dart';  
import 'screens/profile_screen.dart';


void main() {  
  runApp(const MyApp());  
}  

class MyApp extends StatelessWidget {  
  const MyApp({super.key});  

  @override  
  Widget build(BuildContext context) {  
    return MultiProvider(  
      providers: [  
        ChangeNotifierProvider(create: (ctx) => AuthProvider()),  
        ChangeNotifierProvider(create: (ctx) => CartProvider()),  
      ],  
      child: MaterialApp(  
        title: 'E-Commerce App',  
        debugShowCheckedModeBanner: false,  
        theme: ThemeData(  
          colorScheme: ColorScheme.fromSeed(  
            seedColor: Colors.deepPurple,  
            brightness: Brightness.light,  
          ),  
          useMaterial3: true,  
          inputDecorationTheme: InputDecorationTheme(  
            filled: true,  
            fillColor: Colors.grey.shade100,  
            border: OutlineInputBorder(  
              borderRadius: BorderRadius.circular(12),  
              borderSide: BorderSide.none,  
            ),  
            enabledBorder: OutlineInputBorder(  
              borderRadius: BorderRadius.circular(12),  
              borderSide: BorderSide.none,  
            ),  
            focusedBorder: OutlineInputBorder(  
              borderRadius: BorderRadius.circular(12),  
              borderSide: BorderSide(  
                color: Colors.deepPurple.shade200,  
                width: 2,  
              ),  
            ),  
            errorBorder: OutlineInputBorder(  
              borderRadius: BorderRadius.circular(12),  
              borderSide: BorderSide(  
                color: Colors.red.shade200,  
                width: 2,  
              ),  
            ),  
            focusedErrorBorder: OutlineInputBorder(  
              borderRadius: BorderRadius.circular(12),  
              borderSide: BorderSide(  
                color: Colors.red.shade200,  
                width: 2,  
              ),  
            ),  
            contentPadding: const EdgeInsets.symmetric(  
              horizontal: 16,  
              vertical: 16,  
            ),  
          ),  
          elevatedButtonTheme: ElevatedButtonThemeData(  
            style: ElevatedButton.styleFrom(  
              padding: const EdgeInsets.symmetric(  
                horizontal: 24,  
                vertical: 16,  
              ),  
              shape: RoundedRectangleBorder(  
                borderRadius: BorderRadius.circular(12),  
              ),  
            ),  
          ),  
          filledButtonTheme: FilledButtonThemeData(  
            style: FilledButton.styleFrom(  
              padding: const EdgeInsets.symmetric(  
                horizontal: 24,  
                vertical: 16,  
              ),  
              shape: RoundedRectangleBorder(  
                borderRadius: BorderRadius.circular(12),  
              ),  
            ),  
          ),  
          cardTheme: CardTheme(  
            elevation: 0,  
            shape: RoundedRectangleBorder(  
              borderRadius: BorderRadius.circular(16),  
              side: BorderSide(  
                color: Colors.grey.shade200,  
                width: 1,  
              ),  
            ),  
          ),  
        ),  
        darkTheme: ThemeData(  
          colorScheme: ColorScheme.fromSeed(  
            seedColor: Colors.deepPurple,  
            brightness: Brightness.dark,  
          ),  
          useMaterial3: true,  
          inputDecorationTheme: InputDecorationTheme(  
            filled: true,  
            fillColor: Colors.grey.shade900,  
            border: OutlineInputBorder(  
              borderRadius: BorderRadius.circular(12),  
              borderSide: BorderSide.none,  
            ),  
            enabledBorder: OutlineInputBorder(  
              borderRadius: BorderRadius.circular(12),  
              borderSide: BorderSide.none,  
            ),  
            focusedBorder: OutlineInputBorder(  
              borderRadius: BorderRadius.circular(12),  
              borderSide: BorderSide(  
                color: Colors.deepPurple.shade200,  
                width: 2,  
              ),  
            ),  
            errorBorder: OutlineInputBorder(  
              borderRadius: BorderRadius.circular(12),  
              borderSide: BorderSide(  
                color: Colors.red.shade200,  
                width: 2,  
              ),  
            ),  
            focusedErrorBorder: OutlineInputBorder(  
              borderRadius: BorderRadius.circular(12),  
              borderSide: BorderSide(  
                color: Colors.red.shade200,  
                width: 2,  
              ),  
            ),  
            contentPadding: const EdgeInsets.symmetric(  
              horizontal: 16,  
              vertical: 16,  
            ),  
          ),  
          elevatedButtonTheme: ElevatedButtonThemeData(  
            style: ElevatedButton.styleFrom(  
              padding: const EdgeInsets.symmetric(  
                horizontal: 24,  
                vertical: 16,  
              ),  
              shape: RoundedRectangleBorder(  
                borderRadius: BorderRadius.circular(12),  
              ),  
            ),  
          ),  
          filledButtonTheme: FilledButtonThemeData(  
            style: FilledButton.styleFrom(  
              padding: const EdgeInsets.symmetric(  
                horizontal: 24,  
                vertical: 16,  
              ),  
              shape: RoundedRectangleBorder(  
                borderRadius: BorderRadius.circular(12),  
              ),  
            ),  
          ),  
          cardTheme: CardTheme(  
            elevation: 0,  
            shape: RoundedRectangleBorder(  
              borderRadius: BorderRadius.circular(16),  
              side: BorderSide(  
                color: Colors.grey.shade800,  
                width: 1,  
              ),  
            ),  
          ),  
        ),  
        themeMode: ThemeMode.system,  
        initialRoute: VerificationScreen.routeName,  
        routes: {  
          '/': (ctx) => const VerificationScreen(),  
          VerificationScreen.routeName: (ctx) => const VerificationScreen(),  
          HomeScreen.routeName: (ctx) => const HomeScreen(),  
          CartScreen.routeName: (ctx) => const CartScreen(),  
          ProfileScreen.routeName: (ctx) => const ProfileScreen(),  
        },  
      ),  
    );  
  }  
}