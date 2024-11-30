// lib/widgets/product_search_delegate.dart  
import 'package:flutter/material.dart';  
import '../providers/product_provider.dart';  

class ProductSearchDelegate extends SearchDelegate<String> {  
  final ProductProvider productProvider;  

  ProductSearchDelegate({required this.productProvider});  

  @override  
  List<Widget> buildActions(BuildContext context) {  
    return [  
      IconButton(  
        icon: const Icon(Icons.clear),  
        onPressed: () {  
          query = '';  
        },  
      ),  
    ];  
  }  

  @override  
  Widget buildLeading(BuildContext context) {  
    return IconButton(  
      icon: const Icon(Icons.arrow_back),  
      onPressed: () {  
        close(context, '');  
      },  
    );  
  }  

  @override  
  Widget buildResults(BuildContext context) {  
    if (query.isEmpty) {  
      return const Center(  
        child: Text('Enter a search term'),  
      );  
    }  

    final products = productProvider.searchProducts(query);  

    if (products.isEmpty) {  
      return const Center(  
        child: Text('No products found'),  
      );  
    }  

    return ListView.builder(  
      itemCount: products.length,  
      itemBuilder: (context, index) {  
        final product = products[index];  
        return ListTile(  
          leading: Image.network(  
            product.imageUrl,  
            width: 50,  
            height: 50,  
            fit: BoxFit.cover,  
            errorBuilder: (context, error, stackTrace) {  
              return Container(  
                width: 50,  
                height: 50,  
                color: Colors.grey[200],  
                child: const Icon(Icons.error),  
              );  
            },  
          ),  
          title: Text(product.name),  
          subtitle: Text('\$${product.price.toStringAsFixed(2)}'),  
          onTap: () {  
            close(context, product.id);  
          },  
        );  
      },  
    );  
  }  

  @override  
  Widget buildSuggestions(BuildContext context) {  
    return buildResults(context);  
  }  
}