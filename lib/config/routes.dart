import 'package:flutter/material.dart';  
import '../screens/home_screen.dart';  
import '../screens/cart_screen.dart';  
import '../screens/product_detail_screen.dart';  
import '../screens/profile_screen.dart';  

class AppRoutes {  
  static const String home = '/';  
  static const String cart = '/cart';  
  static const String productDetail = '/product';  
  static const String profile = '/profile';  

  static Route<dynamic> generateRoute(RouteSettings settings) {  
    switch (settings.name) {  
      case home:  
        return MaterialPageRoute(  
          builder: (_) => const HomeScreen(),  
        );  
      
      case cart:  
        return MaterialPageRoute(  
          builder: (_) => const CartScreen(),  
        );  
      
      case productDetail:  
        final args = settings.arguments as Map<String, dynamic>?;  
        final productId = args?['productId'] as int? ?? 0;  
        return MaterialPageRoute(  
          builder: (_) => ProductDetailScreen(productId: productId),  
        );  
      
      case profile:  
        return MaterialPageRoute(  
          builder: (_) => const ProfileScreen(),  
        );  
      
      default:  
        return MaterialPageRoute(  
          builder: (_) => Scaffold(  
            body: Center(  
              child: Text('No route defined for ${settings.name}'),  
            ),  
          ),  
        );  
    }  
  }  

  static void navigateToProduct(BuildContext context, int productId) {  
    Navigator.pushNamed(  
      context,  
      productDetail,  
      arguments: {'productId': productId},  
    );  
  }  

  static void navigateToCart(BuildContext context) {  
    Navigator.pushNamed(context, cart);  
  }  

  static void navigateToProfile(BuildContext context) {  
    Navigator.pushNamed(context, profile);  
  }  
}