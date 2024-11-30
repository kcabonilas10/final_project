import 'package:flutter/material.dart';  
import '../models/product.dart';  

class ProductCard extends StatelessWidget {  
  final Product product;  
  final VoidCallback onTap;  
  final VoidCallback onAddToCart;  

  const ProductCard({  
    super.key,  
    required this.product,  
    required this.onTap,  
    required this.onAddToCart,  
  });  

  @override  
  Widget build(BuildContext context) {  
    return GestureDetector(  
      onTap: onTap,  
      child: Card(  
        elevation: 2,  
        shape: RoundedRectangleBorder(  
          borderRadius: BorderRadius.circular(12),  
        ),  
        child: Column(  
          crossAxisAlignment: CrossAxisAlignment.start,  
          children: [  
            // Product Image  
            ClipRRect(  
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),  
              child: AspectRatio(  
                aspectRatio: 1,  
                child: Image.network(  
                  product.imageUrl,  
                  fit: BoxFit.cover,  
                  errorBuilder: (context, error, stackTrace) {  
                    return Container(  
                      color: Colors.grey[300],  
                      child: const Center(  
                        child: Icon(Icons.error_outline),  
                      ),  
                    );  
                  },  
                ),  
              ),  
            ),  
            
            // Product Details  
            Padding(  
              padding: const EdgeInsets.all(8.0),  
              child: Column(  
                crossAxisAlignment: CrossAxisAlignment.start,  
                children: [  
                  // Product Name  
                  Text(  
                    product.name,  
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(  
                          fontWeight: FontWeight.bold,  
                        ),  
                    maxLines: 2,  
                    overflow: TextOverflow.ellipsis,  
                  ),  
                  const SizedBox(height: 4),  
                  
                  // Product Price  
                  Text(  
                    '\$${product.price.toStringAsFixed(2)}',  
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(  
                          color: Theme.of(context).primaryColor,  
                          fontWeight: FontWeight.bold,  
                        ),  
                  ),  
                  const SizedBox(height: 8),  
                  
                  // Add to Cart Button  
                  SizedBox(  
                    width: double.infinity,  
                    child: ElevatedButton(  
                      onPressed: onAddToCart,  
                      style: ElevatedButton.styleFrom(  
                        padding: const EdgeInsets.symmetric(vertical: 8),  
                        shape: RoundedRectangleBorder(  
                          borderRadius: BorderRadius.circular(8),  
                        ),  
                      ),  
                      child: const Text('Add to Cart'),  
                    ),  
                  ),  
                ],  
              ),  
            ),  
          ],  
        ),  
      ),  
    );  
  }  
}