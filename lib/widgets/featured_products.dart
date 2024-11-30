// lib/widgets/featured_products.dart  
import 'package:flutter/material.dart';  
import 'package:provider/provider.dart';  
import '../providers/cart_provider.dart';  
import '../providers/product_provider.dart';  


class FeaturedProducts extends StatelessWidget {  
  const FeaturedProducts({super.key});  

  // Helper method to get quantity from cart  
  int _getQuantityInCart(CartProvider cart, String productId) {  
    return cart.items.containsKey(productId)   
        ? cart.items[productId]!.quantity   
        : 0;  
  }  

  @override  
  Widget build(BuildContext context) {  
    final productProvider = Provider.of<ProductProvider>(context);  
    final cartProvider = Provider.of<CartProvider>(context);  
    final products = productProvider.products;  

    return GridView.builder(  
      padding: const EdgeInsets.all(10.0),  
      itemCount: products.length,  
      itemBuilder: (ctx, i) {  
        final product = products[i];  
        final quantityInCart = _getQuantityInCart(cartProvider, product.id);  

        return Card(  
          elevation: 5,  
          child: Column(  
            crossAxisAlignment: CrossAxisAlignment.start,  
            children: <Widget>[  
              Expanded(  
                child: Stack(  
                  children: [  
                    Container(  
                      width: double.infinity,  
                      decoration: BoxDecoration(  
                        image: DecorationImage(  
                          image: NetworkImage(product.imageUrl),  
                          fit: BoxFit.cover,  
                        ),  
                      ),  
                    ),  
                    if (quantityInCart > 0)  
                      Positioned(  
                        top: 8,  
                        right: 8,  
                        child: CircleAvatar(  
                          backgroundColor: Theme.of(context).colorScheme.primary,  
                          child: Text(  
                            quantityInCart.toString(),  
                            style: const TextStyle(color: Colors.white),  
                          ),  
                        ),  
                      ),  
                  ],  
                ),  
              ),  
              Padding(  
                padding: const EdgeInsets.all(8.0),  
                child: Column(  
                  crossAxisAlignment: CrossAxisAlignment.start,  
                  children: [  
                    Text(  
                      product.name,  
                      style: Theme.of(context).textTheme.titleMedium,  
                      maxLines: 1,  
                      overflow: TextOverflow.ellipsis,  
                    ),  
                    Text(  
                      '\$${product.price.toStringAsFixed(2)}',  
                      style: Theme.of(context).textTheme.titleSmall,  
                    ),  
                    const SizedBox(height: 8),  
                    Row(  
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,  
                      children: [  
                        if (quantityInCart > 0) ...[  
                          IconButton(  
                            icon: const Icon(Icons.remove),  
                            onPressed: () {  
                              cartProvider.removeSingleItem(product.id);  
                            },  
                          ),  
                          Text('$quantityInCart'),  
                        ],  
                        IconButton(  
                          icon: const Icon(Icons.add_shopping_cart),  
                          onPressed: () {  
                            cartProvider.addItem(  
                              product.id,  
                              product.name,  
                              product.price,  
                              product.imageUrl,  
                            );  
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();  
                            ScaffoldMessenger.of(context).showSnackBar(  
                              SnackBar(  
                                content: const Text('Added item to cart!'),  
                                duration: const Duration(seconds: 2),  
                                action: SnackBarAction(  
                                  label: 'UNDO',  
                                  onPressed: () {  
                                    cartProvider.removeSingleItem(product.id);  
                                  },  
                                ),  
                              ),  
                            );  
                          },  
                        ),  
                      ],  
                    ),  
                  ],  
                ),  
              ),  
            ],  
          ),  
        );  
      },  
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(  
        crossAxisCount: 2,  
        childAspectRatio: 2/3,  
        crossAxisSpacing: 10,  
        mainAxisSpacing: 10,  
      ),  
    );  
  }  
}