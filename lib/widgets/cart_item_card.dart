// lib/widgets/cart_item_card.dart  
import 'package:flutter/material.dart';  
import 'package:provider/provider.dart';  
import '../providers/cart_provider.dart';  

class CartItemCard extends StatelessWidget {  
  final String productId;  
  final CartItem item;  

  const CartItemCard({  
    super.key,  
    required this.productId,  
    required this.item,  
  });  

  @override  
  Widget build(BuildContext context) {  
    return Dismissible(  
      key: ValueKey(item.id),  
      background: Container(  
        color: Theme.of(context).colorScheme.error,  
        alignment: Alignment.centerRight,  
        padding: const EdgeInsets.only(right: 20),  
        margin: const EdgeInsets.symmetric(  
          horizontal: 15,  
          vertical: 4,  
        ),  
        child: const Icon(  
          Icons.delete,  
          color: Colors.white,  
          size: 40,  
        ),  
      ),  
      direction: DismissDirection.endToStart,  
      confirmDismiss: (direction) {  
        return showDialog(  
          context: context,  
          builder: (ctx) => AlertDialog(  
            title: const Text('Are you sure?'),  
            content: const Text(  
              'Do you want to remove the item from the cart?',  
            ),  
            actions: [  
              TextButton(  
                child: const Text('No'),  
                onPressed: () {  
                  Navigator.of(ctx).pop(false);  
                },  
              ),  
              FilledButton(  
                child: const Text('Yes'),  
                onPressed: () {  
                  Navigator.of(ctx).pop(true);  
                },  
              ),  
            ],  
          ),  
        );  
      },  
      onDismissed: (direction) {  
        Provider.of<CartProvider>(context, listen: false)  
            .removeItem(productId);  
      },  
      child: Card(  
        margin: const EdgeInsets.symmetric(  
          horizontal: 15,  
          vertical: 4,  
        ),  
        child: Padding(  
          padding: const EdgeInsets.all(8),  
          child: ListTile(  
            leading: CircleAvatar(  
              backgroundColor: Theme.of(context).colorScheme.primary,  
              child: Padding(  
                padding: const EdgeInsets.all(5),  
                child: FittedBox(  
                  child: Text('\$${item.price.toStringAsFixed(2)}'),  
                ),  
              ),  
            ),  
            title: Text(item.title),  
            subtitle: Text(  
              'Total: \$${(item.price * item.quantity).toStringAsFixed(2)}',  
            ),  
            trailing: SizedBox(  
              width: 120,  
              child: Row(  
                mainAxisSize: MainAxisSize.min,  
                children: [  
                  IconButton(  
                    icon: const Icon(Icons.remove),  
                    onPressed: () {  
                      Provider.of<CartProvider>(context, listen: false)  
                          .removeSingleItem(productId);  
                    },  
                  ),  
                  Text('${item.quantity} x'),  
                  IconButton(  
                    icon: const Icon(Icons.add),  
                    onPressed: () {  
                      Provider.of<CartProvider>(context, listen: false)  
                          .addItem(  
                            productId,  
                            item.title,  
                            item.price,  
                            item.imageUrl,  
                          );  
                    },  
                  ),  
                ],  
              ),  
            ),  
          ),  
        ),  
      ),  
    );  
  }  
}