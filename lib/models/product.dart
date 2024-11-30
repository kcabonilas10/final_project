// lib/models/product.dart  
class Product {  
  final String id;  
  final String name;  
  final String imageUrl;  
  final double price;  
  final String? description;  
  final String categoryId;  
  final bool isFeatured;  
  final double rating;  
  final int reviewCount;  

  const Product({  
    required this.id,  
    required this.name,  
    required this.imageUrl,  
    required this.price,  
    this.description,  
    required this.categoryId,  
    this.isFeatured = false,  
    this.rating = 0.0,  
    this.reviewCount = 0,  
  });  

  Product copyWith({  
    String? id,  
    String? name,  
    String? imageUrl,  
    double? price,  
    String? description,  
    String? categoryId,  
    bool? isFeatured,  
    double? rating,  
    int? reviewCount,  
  }) {  
    return Product(  
      id: id ?? this.id,  
      name: name ?? this.name,  
      imageUrl: imageUrl ?? this.imageUrl,  
      price: price ?? this.price,  
      description: description ?? this.description,  
      categoryId: categoryId ?? this.categoryId,  
      isFeatured: isFeatured ?? this.isFeatured,  
      rating: rating ?? this.rating,  
      reviewCount: reviewCount ?? this.reviewCount,  
    );  
  }  
}  