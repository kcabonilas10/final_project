// lib/widgets/category_card.dart  
import 'package:flutter/material.dart';  

class CategoryCard extends StatelessWidget {  
  final IconData icon;  
  final String name;  
  final VoidCallback onTap;  

  const CategoryCard({  
    super.key,  
    required this.icon,  
    required this.name,  
    required this.onTap,  
  });  

  @override  
  Widget build(BuildContext context) {  
    return GestureDetector(  
      onTap: onTap,  
      child: Container(  
        width: 80,  
        margin: const EdgeInsets.only(right: 16),  
        child: Column(  
          mainAxisAlignment: MainAxisAlignment.center,  
          children: [  
            Container(  
              padding: const EdgeInsets.all(12),  
              decoration: BoxDecoration(  
                color: Theme.of(context).primaryColor.withOpacity(0.1),  
                shape: BoxShape.circle,  
              ),  
              child: Icon(  
                icon,  
                color: Theme.of(context).primaryColor,  
              ),  
            ),  
            const SizedBox(height: 8),  
            Text(  
              name,  
              textAlign: TextAlign.center,  
              style: Theme.of(context).textTheme.bodySmall,  
              maxLines: 2,  
              overflow: TextOverflow.ellipsis,  
            ),  
          ],  
        ),  
      ),  
    );  
  }  
}