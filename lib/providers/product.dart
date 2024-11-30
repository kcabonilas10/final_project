// lib/models/product.dart  
class Product {  
  final String id;  // Changed from int to String  
  final String name;  
  final String description;  
  final double price;  
  final String imageUrl;  
  final String category;  

  Product({  
    required this.id,  
    required this.name,  
    required this.description,  
    required this.price,  
    required this.imageUrl,  
    required this.category,  
  });  
}

  