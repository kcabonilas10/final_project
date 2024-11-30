class CartItem {  
  final String id;  
  final String productId;  
  final String name;  // Changed from title  
  final int quantity;  
  final double price;  
  final String imageUrl;  
  final Map<String, String> selectedOptions;  // Added for product variations  
  
  // Computed property for total  
  double get total => price * quantity;  

  CartItem({  
    required this.id,  
    required this.productId,  
    required this.name,  // Changed from title  
    required this.quantity,  
    required this.price,  
    required this.imageUrl,  
    required this.selectedOptions,  // Added  
  });  

  // Create a copy of the cart item with updated fields  
  CartItem copyWith({  
    String? id,  
    String? productId,  
    String? name,  
    int? quantity,  
    double? price,  
    String? imageUrl,  
    Map<String, String>? selectedOptions,  
  }) {  
    return CartItem(  
      id: id ?? this.id,  
      productId: productId ?? this.productId,  
      name: name ?? this.name,  
      quantity: quantity ?? this.quantity,  
      price: price ?? this.price,  
      imageUrl: imageUrl ?? this.imageUrl,  
      selectedOptions: selectedOptions ?? this.selectedOptions,  
    );  
  }  
}  