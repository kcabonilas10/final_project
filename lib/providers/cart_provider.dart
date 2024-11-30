// lib/providers/cart_provider.dart  
import 'package:flutter/foundation.dart';  

class CartItem {  
  final String id;  
  final String title;  
  final double price;  
  final int quantity;  
  final String imageUrl;  

  CartItem({  
    required this.id,  
    required this.title,  
    required this.price,  
    required this.quantity,  
    required this.imageUrl,  
  });  
}  

class CartProvider with ChangeNotifier {  
  Map<String, CartItem> _items = {};  

  Map<String, CartItem> get items {  
    return {..._items};  
  }  

  int get itemCount {  
    return _items.length;  
  }  

  double get totalAmount {  
    var total = 0.0;  
    _items.forEach((key, cartItem) {  
      total += cartItem.price * cartItem.quantity;  
    });  
    return total;  
  }  

  void addItem(String productId, String title, double price, String imageUrl) {  
    if (_items.containsKey(productId)) {  
      _items.update(  
        productId,  
        (existingCartItem) => CartItem(  
          id: existingCartItem.id,  
          title: existingCartItem.title,  
          price: existingCartItem.price,  
          quantity: existingCartItem.quantity + 1,  
          imageUrl: existingCartItem.imageUrl,  
        ),  
      );  
    } else {  
      _items.putIfAbsent(  
        productId,  
        () => CartItem(  
          id: DateTime.now().toString(),  
          title: title,  
          price: price,  
          quantity: 1,  
          imageUrl: imageUrl,  
        ),  
      );  
    }  
    notifyListeners();  
  }  

  void removeItem(String productId) {  
    _items.remove(productId);  
    notifyListeners();  
  }  

  void removeSingleItem(String productId) {  
    if (!_items.containsKey(productId)) {  
      return;  
    }  
    if (_items[productId]!.quantity > 1) {  
      _items.update(  
        productId,  
        (existingCartItem) => CartItem(  
          id: existingCartItem.id,  
          title: existingCartItem.title,  
          price: existingCartItem.price,  
          quantity: existingCartItem.quantity - 1,  
          imageUrl: existingCartItem.imageUrl,  
        ),  
      );  
    } else {  
      _items.remove(productId);  
    }  
    notifyListeners();  
  }  

  void clear() {  
    _items = {};  
    notifyListeners();  
  }  
}