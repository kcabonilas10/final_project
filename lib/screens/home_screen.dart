// lib/screens/home_screen.dart  
import 'package:flutter/material.dart';  
import 'package:provider/provider.dart';  
import '../providers/cart_provider.dart';  
import '../screens/cart_screen.dart';  
import '../widgets/category_grid.dart';
import '../screens/profile_screen.dart';  

class HomeScreen extends StatelessWidget {  
  static const String routeName = '/home';  

  const HomeScreen({super.key});  

  @override  
  Widget build(BuildContext context) {  
    return Scaffold(  
      body: CustomScrollView(  
        slivers: [  
          SliverAppBar(  
            floating: true,  
            title: const Text('E-Commerce App'),  
            actions: [  
              IconButton(  
                icon: const Icon(Icons.search),  
                onPressed: () {  
                  // Implement search functionality  
                },  
              ),  
              Stack(  
                children: [  
                  IconButton(  
                    icon: const Icon(Icons.shopping_cart),  
                    onPressed: () {  
                      Navigator.of(context).pushNamed(CartScreen.routeName);  
                    },  
                  ),  
                  Positioned(  
                    right: 8,  
                    top: 8,  
                    child: Consumer<CartProvider>(  
                      builder: (ctx, cart, child) => cart.itemCount > 0  
                          ? Container(  
                              padding: const EdgeInsets.all(2),  
                              decoration: BoxDecoration(  
                                color: Theme.of(context).colorScheme.error,  
                                borderRadius: BorderRadius.circular(10),  
                              ),  
                              constraints: const BoxConstraints(  
                                minWidth: 16,  
                                minHeight: 16,  
                              ),  
                              child: Text(  
                                '${cart.itemCount}',  
                                textAlign: TextAlign.center,  
                                style: const TextStyle(  
                                  fontSize: 10,  
                                  color: Colors.white,  
                                ),  
                              ),  
                            )  
                          : const SizedBox(),  
                    ),  
                  ),  
                ],  
              ),  
            ],  
          ),  
          SliverToBoxAdapter(  
            child: Column(  
              crossAxisAlignment: CrossAxisAlignment.start,  
              children: [  
                Padding(  
                  padding: const EdgeInsets.all(16),  
                  child: Text(  
                    'Categories',  
                    style: Theme.of(context).textTheme.titleLarge,  
                  ),  
                ),  
                CategoryGrid(),  
                // Add more sections like featured products, deals, etc.  
              ],  
            ),  
          ),  
        ],  
      ),  
      bottomNavigationBar: NavigationBar(  
        destinations: const [  
          NavigationDestination(  
            icon: Icon(Icons.home_outlined),  
            selectedIcon: Icon(Icons.home),  
            label: 'Home',  
          ),  
          NavigationDestination(  
            icon: Icon(Icons.category_outlined),  
            selectedIcon: Icon(Icons.category),  
            label: 'Categories',  
          ),  
          NavigationDestination(  
            icon: Icon(Icons.favorite_outline),  
            selectedIcon: Icon(Icons.favorite),  
            label: 'Wishlist',  
          ),  
          NavigationDestination(  
            icon: Icon(Icons.person_outline),  
            selectedIcon: Icon(Icons.person),  
            label: 'Profile',  
          ),  
        ],  
        selectedIndex: 0,  
        onDestinationSelected: (index) {  
          // Implement navigation logic  
          switch (index) {  
            case 0:  
              // Already on home  
              break;  
            case 1:  
              // Navigate to categories  
              break;  
            case 2:  
              // Navigate to wishlist  
              break;  
            case 3:  
              Navigator.of(context).pushNamed(ProfileScreen.routeName);  
              break;  
          }  
        },  
      ),  
    );  
  }  
}