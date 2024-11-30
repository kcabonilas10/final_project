import 'package:flutter/material.dart';  
import 'package:provider/provider.dart';  
import 'package:firebase_core/firebase_core.dart';  
import 'providers/cart_provider.dart';  
import 'providers/auth_provider.dart';  
import 'screens/auth/verification_screen.dart';  
import 'screens/home_screen.dart';  
import 'screens/cart_screen.dart';  
import 'screens/profile_screen.dart';  

void main() async {  
  WidgetsFlutterBinding.ensureInitialized();  
  await Firebase.initializeApp();  
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
      child: Consumer<AuthProvider>(  
        builder: (context, authProvider, _) {  
          return MaterialApp(  
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
                  borderSide: const BorderSide(  
                    color: Colors.deepPurple,  
                    width: 2,  
                  ),  
                ),  
                errorBorder: OutlineInputBorder(  
                  borderRadius: BorderRadius.circular(12),  
                  borderSide: const BorderSide(  
                    color: Colors.red,  
                    width: 2,  
                  ),  
                ),  
                focusedErrorBorder: OutlineInputBorder(  
                  borderRadius: BorderRadius.circular(12),  
                  borderSide: const BorderSide(  
                    color: Colors.red,  
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
                  elevation: 0,  
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
              textButtonTheme: TextButtonThemeData(  
                style: TextButton.styleFrom(  
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
                ),  
                color: Colors.white,  
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
                  borderSide: const BorderSide(  
                    color: Colors.deepPurple,  
                    width: 2,  
                  ),  
                ),  
                errorBorder: OutlineInputBorder(  
                  borderRadius: BorderRadius.circular(12),  
                  borderSide: const BorderSide(  
                    color: Colors.red,  
                    width: 2,  
                  ),  
                ),  
                focusedErrorBorder: OutlineInputBorder(  
                  borderRadius: BorderRadius.circular(12),  
                  borderSide: const BorderSide(  
                    color: Colors.red,  
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
                  elevation: 0,  
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
              textButtonTheme: TextButtonThemeData(  
                style: TextButton.styleFrom(  
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
                ),  
                color: Colors.grey.shade900,  
              ),  
            ),  
            themeMode: ThemeMode.system,  
            initialRoute: authProvider.isAuthenticated  
                ? HomeScreen.routeName  
                : VerificationScreen.routeName,  
            routes: {  
              '/': (ctx) => const VerificationScreen(),  
              VerificationScreen.routeName: (ctx) => const VerificationScreen(),  
              HomeScreen.routeName: (ctx) => const HomeScreen(),  
              CartScreen.routeName: (ctx) => const CartScreen(),  
              ProfileScreen.routeName: (ctx) => const ProfileScreen(),  
            },  
          );  
        },  
      ),  
    );  
  }  
}