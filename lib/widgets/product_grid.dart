import 'package:flutter/material.dart';  
import '../models/product.dart';  
import 'product_card.dart';  

class ProductGrid extends StatelessWidget {  
  final List<Product> products;  
  final void Function(Product) onProductTap;  
  final void Function(Product) onAddToCart;  

  const ProductGrid({  
    super.key,  
    required this.products,  
    required this.onProductTap,  
    required this.onAddToCart,  
  });  

  @override  
  Widget build(BuildContext context) {  
    return GridView.builder(  
      padding: const EdgeInsets.all(16),  
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(  
        crossAxisCount: 2,  
        childAspectRatio: 0.75,  
        mainAxisSpacing: 16,  
        crossAxisSpacing: 16,  
      ),  
      itemCount: products.length,  
      itemBuilder: (context, index) {  
        final product = products[index];  
        return ProductCard(  
          product: product,  
          onTap: () => onProductTap(product),  
          onAddToCart: () => onAddToCart(product),  
        );  
      },  
    );  
  }  
}