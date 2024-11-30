// lib/screens/cart_screen.dart  
import 'package:flutter/material.dart';  
import 'package:provider/provider.dart';  
import '../providers/cart_provider.dart';  
import '../widgets/cart_item_card.dart';  

class CartScreen extends StatelessWidget {  
  static const String routeName = '/cart';  

  const CartScreen({super.key});  

  @override  
  Widget build(BuildContext context) {  
    final cart = Provider.of<CartProvider>(context);  
    
    return Scaffold(  
      appBar: AppBar(  
        title: const Text('Shopping Cart'),  
      ),  
      body: cart.items.isEmpty  
          ? Center(  
              child: Column(  
                mainAxisAlignment: MainAxisAlignment.center,  
                children: [  
                  Icon(  
                    Icons.shopping_cart_outlined,  
                    size: 64,  
                    color: Theme.of(context).colorScheme.secondary,  
                  ),  
                  const SizedBox(height: 16),  
                  Text(  
                    'Your cart is empty',  
                    style: Theme.of(context).textTheme.headlineSmall,  
                  ),  
                  const SizedBox(height: 8),  
                  TextButton(  
                    onPressed: () {  
                      Navigator.of(context).pop();  
                    },  
                    child: const Text('Start Shopping'),  
                  ),  
                ],  
              ),  
            )  
          : Column(  
              children: [  
                Expanded(  
                  child: ListView.builder(  
                    padding: const EdgeInsets.all(16),  
                    itemCount: cart.items.length,  
                    itemBuilder: (ctx, i) {  
                      final item = cart.items.values.toList()[i];  
                      final productId = cart.items.keys.toList()[i];  
                      return CartItemCard(  
                        item: item,  
                        productId: productId,  
                      );  
                    },  
                  ),  
                ),  
                Container(  
                  padding: const EdgeInsets.all(16),  
                  decoration: BoxDecoration(  
                    color: Theme.of(context).colorScheme.surface,  
                    borderRadius: const BorderRadius.vertical(  
                      top: Radius.circular(20),  
                    ),  
                    boxShadow: [  
                      BoxShadow(  
                        color: Colors.black.withOpacity(0.05),  
                        blurRadius: 10,  
                        offset: const Offset(0, -5),  
                      ),  
                    ],  
                  ),  
                  child: SafeArea(  
                    child: Column(  
                      mainAxisSize: MainAxisSize.min,  
                      children: [  
                        Row(  
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,  
                          children: [  
                            Text(  
                              'Total:',  
                              style: Theme.of(context).textTheme.titleLarge,  
                            ),  
                            Text(  
                              '\$${cart.totalAmount.toStringAsFixed(2)}',  
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(  
                                    color: Theme.of(context).colorScheme.primary,  
                                    fontWeight: FontWeight.bold,  
                                  ),  
                            ),  
                          ],  
                        ),  
                        const SizedBox(height: 16),  
                        FilledButton(  
                          onPressed: cart.totalAmount <= 0  
                              ? null  
                              : () {  
                                  // Implement checkout logic  
                                },  
                          style: FilledButton.styleFrom(  
                            minimumSize: const Size.fromHeight(50),  
                          ),  
                          child: const Text('Proceed to Checkout'),  
                        ),  
                      ],  
                    ),  
                  ),  
                ),  
              ],  
            ),  
    );  
  }  
}