// lib/models/order.dart  
import 'cart_item.dart';  

enum OrderStatus {  
  pending,  
  processing,  
  shipped,  
  delivered,  
  cancelled  
}  

class Order {  
  final String id;  
  final List<CartItem> items;  
  final double total;  
  final DateTime dateTime;  
  final OrderStatus status;  

  const Order({  
    required this.id,  
    required this.items,  
    required this.total,  
    required this.dateTime,  
    required this.status,  
  });  
}