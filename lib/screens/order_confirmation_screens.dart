// lib/screens/order_confirmation_screen.dart  
import 'package:flutter/material.dart';  
import 'package:provider/provider.dart';  
import '../providers/order_provider.dart';  
import '../models/cart_item.dart';  

class OrderConfirmationScreen extends StatelessWidget {  
  final String orderId;  

  const OrderConfirmationScreen({  
    super.key,  
    required this.orderId,  
  });  

  @override  
  Widget build(BuildContext context) {  
    final order = Provider.of<OrderProvider>(context).getOrderById(orderId);  

    if (order == null) {  
      return Scaffold(  
        appBar: AppBar(  
          title: const Text('Order Not Found'),  
        ),  
        body: const Center(  
          child: Text('Could not find order details'),  
        ),  
      );  
    }  

    return Scaffold(  
      appBar: AppBar(  
        title: const Text('Order Confirmation'),  
      ),  
      body: SingleChildScrollView(  
        padding: const EdgeInsets.all(16),  
        child: Column(  
          crossAxisAlignment: CrossAxisAlignment.start,  
          children: [  
            // Success Icon and Message  
            Center(  
              child: Column(  
                children: [  
                  const Icon(  
                    Icons.check_circle_outline,  
                    color: Colors.green,  
                    size: 64,  
                  ),  
                  const SizedBox(height: 16),  
                  Text(  
                    'Thank you for your order!',  
                    style: Theme.of(context).textTheme.headlineSmall,  
                    textAlign: TextAlign.center,  
                  ),  
                  const SizedBox(height: 8),  
                  Text(  
                    'Order #${order.id}',  
                    style: Theme.of(context).textTheme.titleMedium,  
                  ),  
                ],  
              ),  
            ),  
            const SizedBox(height: 32),  

            // Order Details  
            Text(  
              'Order Details',  
              style: Theme.of(context).textTheme.titleLarge,  
            ),  
            const SizedBox(height: 16),  

            // Order Items  
            Card(  
              child: ListView.separated(  
                shrinkWrap: true,  
                physics: const NeverScrollableScrollPhysics(),  
                itemCount: order.items.length,  
                separatorBuilder: (context, index) => const Divider(),  
                itemBuilder: (context, index) {  
                  final CartItem item = order.items[index];  
                  return ListTile(  
                    leading: ClipRRect(  
                      borderRadius: BorderRadius.circular(8),  
                      child: Image.network(  
                        item.imageUrl,  
                        width: 56,  
                        height: 56,  
                        fit: BoxFit.cover,  
                      ),  
                    ),  
                    title: Text(item.name),  // Changed from title to name  
                    subtitle: Column(  
                      crossAxisAlignment: CrossAxisAlignment.start,  
                      children: [  
                        Text('Quantity: ${item.quantity}'),  
                        if (item.selectedOptions.isNotEmpty) ...[  
                          const SizedBox(height: 4),  
                          ...item.selectedOptions.entries.map(  
                            (option) => Text(  
                              '${option.key}: ${option.value}',  
                              style: Theme.of(context).textTheme.bodySmall,  
                            ),  
                          ),  
                        ],  
                      ],  
                    ),  
                    trailing: Text(  
                      '\$${(item.price * item.quantity).toStringAsFixed(2)}',  
                      style: Theme.of(context).textTheme.titleMedium,  
                    ),  
                  );  
                },  
              ),  
            ),  
            const SizedBox(height: 24),  

            // Order Summary  
            Card(  
              child: Padding(  
                padding: const EdgeInsets.all(16),  
                child: Column(  
                  crossAxisAlignment: CrossAxisAlignment.start,  
                  children: [  
                    Text(  
                      'Order Summary',  
                      style: Theme.of(context).textTheme.titleMedium,  
                    ),  
                    const SizedBox(height: 16),  
                    Row(  
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,  
                      children: [  
                        const Text('Subtotal:'),  
                        Text('\$${order.total.toStringAsFixed(2)}'),  
                      ],  
                    ),  
                    const SizedBox(height: 8),  
                    const Row(  
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,  
                      children: [  
                        Text('Shipping:'),  
                        Text('Free'),  
                      ],  
                    ),  
                    const Divider(),  
                    Row(  
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,  
                      children: [  
                        Text(  
                          'Total:',  
                          style: Theme.of(context).textTheme.titleMedium,  
                        ),  
                        Text(  
                          '\$${order.total.toStringAsFixed(2)}',  
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(  
                                color: Theme.of(context).colorScheme.primary,  
                              ),  
                        ),  
                      ],  
                    ),  
                  ],  
                ),  
              ),  
            ),  
            const SizedBox(height: 24),  

            // Continue Shopping Button  
            SizedBox(  
              width: double.infinity,  
              child: FilledButton(  
                onPressed: () {  
                  Navigator.of(context).pushNamedAndRemoveUntil(  
                    '/',  
                    (route) => false,  
                  );  
                },  
                child: const Text('Continue Shopping'),  
              ),  
            ),  
          ],  
        ),  
      ),  
    );  
  }  
}