// lib/providers/order_provider.dart  
import 'package:flutter/foundation.dart';  
import '../models/cart_item.dart';  
import '../models/order.dart';  

class OrderProvider with ChangeNotifier {  
  final List<Order> _orders = [];  

  List<Order> get orders => [..._orders];  

  Future<String> createOrder({  
    required List<CartItem> items,  
    required double total,  
  }) async {  
    try {  
      // Simulate API call  
      await Future.delayed(const Duration(seconds: 2));  

      final order = Order(  
        id: DateTime.now().toString(),  
        items: items,  
        total: total,  
        dateTime: DateTime.now(),  
        status: OrderStatus.pending,  
      );  

      _orders.add(order);  
      notifyListeners();  
      
      return order.id;  
    } catch (error) {  
      throw Exception('Failed to create order: $error');  
    }  
  }  

  Order? getOrderById(String id) {  
    try {  
      return _orders.firstWhere((order) => order.id == id);  
    } catch (_) {  
      return null;  
    }  
  }  
}