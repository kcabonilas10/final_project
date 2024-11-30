// lib/widgets/category_scroller.dart  
import 'package:flutter/material.dart';  
import '../models/category.dart';  
import '../providers/product_provider.dart';  
import 'package:provider/provider.dart';  

class CategoryScroller extends StatelessWidget {  
  const CategoryScroller({super.key});  

  @override  
  Widget build(BuildContext context) {  
    return Consumer<ProductProvider>(  
      builder: (context, provider, child) {  
        if (provider.categories.isEmpty) {  
          return const SizedBox.shrink();  
        }  

        return Column(  
          crossAxisAlignment: CrossAxisAlignment.start,  
          children: [  
            Padding(  
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),  
              child: Text(  
                'Categories',  
                style: Theme.of(context).textTheme.titleMedium,  
              ),  
            ),  
            SizedBox(  
              height: 100,  
              child: ListView.builder(  
                scrollDirection: Axis.horizontal,  
                padding: const EdgeInsets.symmetric(horizontal: 8),  
                itemCount: provider.categories.length + 1, // +1 for "All" category  
                itemBuilder: (context, index) {  
                  if (index == 0) {  
                    return _CategoryItem(  
                      isSelected: provider.selectedCategory == null,  
                      onTap: () => provider.filterByCategory(null),  
                      icon: '🏷️',  
                      label: 'All',  
                    );  
                  }  

                  final ProductCategory category = provider.categories[index - 1];  
                  return _CategoryItem(  
                    isSelected: provider.selectedCategory == category.id,  
                    onTap: () => provider.filterByCategory(category.id),  
                    icon: category.icon,  
                    label: category.name,  
                  );  
                },  
              ),  
            ),  
          ],  
        );  
      },  
    );  
  }  
}  

class _CategoryItem extends StatelessWidget {  
  final bool isSelected;  
  final VoidCallback onTap;  
  final String icon;  
  final String label;  

  const _CategoryItem({  
    required this.isSelected,  
    required this.onTap,  
    required this.icon,  
    required this.label,  
  });  

  @override  
  Widget build(BuildContext context) {  
    final colorScheme = Theme.of(context).colorScheme;  
    
    return Padding(  
      padding: const EdgeInsets.symmetric(horizontal: 8),  
      child: InkWell(  
        onTap: onTap,  
        borderRadius: BorderRadius.circular(12),  
        child: Container(  
          width: 80,  
          decoration: BoxDecoration(  
            color: isSelected  
                ? colorScheme.primaryContainer  
                : colorScheme.surface,  
            borderRadius: BorderRadius.circular(12),  
            border: Border.all(  
              color: isSelected  
                  ? colorScheme.primary  
                  : colorScheme.outline,  
              width: 1,  
            ),  
            boxShadow: isSelected  
                ? [  
                    BoxShadow(  
                      color: colorScheme.primary.withOpacity(0.1),  
                      blurRadius: 8,  
                      offset: const Offset(0, 2),  
                    ),  
                  ]  
                : null,  
          ),  
          child: Column(  
            mainAxisAlignment: MainAxisAlignment.center,  
            children: [  
              Text(  
                icon,  
                style: const TextStyle(fontSize: 24),  
              ),  
              const SizedBox(height: 4),  
              Text(  
                label,  
                style: Theme.of(context).textTheme.labelSmall?.copyWith(  
                      color: isSelected  
                          ? colorScheme.primary  
                          : colorScheme.onSurface,  
                      fontWeight: isSelected  
                          ? FontWeight.bold  
                          : FontWeight.normal,  
                    ),  
                maxLines: 1,  
                overflow: TextOverflow.ellipsis,  
                textAlign: TextAlign.center,  
              ),  
            ],  
          ),  
        ),  
      ),  
    );  
  }  
} 