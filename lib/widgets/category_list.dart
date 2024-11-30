// lib/widgets/category_list.dart  
import 'package:flutter/material.dart';  
import 'package:provider/provider.dart';  
import '../models/category.dart';  
import '../providers/product_provider.dart';  

class CategoryList extends StatelessWidget {  
  final bool showAllOption;  
  final double? height;  
  final ScrollPhysics? physics;  
  final EdgeInsetsGeometry? padding;  

  const CategoryList({  
    super.key,  
    this.showAllOption = true,  
    this.height,  
    this.physics,  
    this.padding,  
  });  

  @override  
  Widget build(BuildContext context) {  
    return Consumer<ProductProvider>(  
      builder: (context, provider, child) {  
        final categories = provider.categories;  
        
        if (categories.isEmpty) {  
          return const SizedBox.shrink();  
        }  

        return SizedBox(  
          height: height ?? 100,  
          child: ListView.builder(  
            scrollDirection: Axis.horizontal,  
            physics: physics ?? const BouncingScrollPhysics(),  
            padding: padding ?? const EdgeInsets.symmetric(horizontal: 16),  
            itemCount: showAllOption ? categories.length + 1 : categories.length,  
            itemBuilder: (context, index) {  
              if (showAllOption && index == 0) {  
                return Padding(  
                  padding: const EdgeInsets.only(right: 12),  
                  child: _CategoryItem(  
                    isSelected: provider.selectedCategory == null, // Changed from selectedCategoryId  
                    onTap: () => provider.filterByCategory(null),  
                    category: const ProductCategory(  
                      id: 'all',  
                      name: 'All',  
                      icon: '🏷️',  
                    ),  
                  ),  
                );  
              }  

              final actualIndex = showAllOption ? index - 1 : index;  
              final category = categories[actualIndex];  

              return Padding(  
                padding: const EdgeInsets.only(right: 12),  
                child: _CategoryItem(  
                  isSelected: provider.selectedCategory == category.id, // Changed from selectedCategoryId  
                  onTap: () => provider.filterByCategory(category.id),  
                  category: category,  
                ),  
              );  
            },  
          ),  
        );  
      },  
    );  
  }  
}  

class _CategoryItem extends StatelessWidget {  
  final bool isSelected;  
  final VoidCallback onTap;  
  final ProductCategory category;  

  const _CategoryItem({  
    required this.isSelected,  
    required this.onTap,  
    required this.category,  
  });  

  @override  
  Widget build(BuildContext context) {  
    final theme = Theme.of(context);  
    
    return Material(  
      color: Colors.transparent,  
      child: InkWell(  
        onTap: onTap,  
        borderRadius: BorderRadius.circular(12),  
        child: Container(  
          width: 80,  
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),  
          decoration: BoxDecoration(  
            color: isSelected  
                ? theme.colorScheme.primaryContainer  
                : theme.colorScheme.surface,  
            borderRadius: BorderRadius.circular(12),  
            border: Border.all(  
              color: isSelected  
                  ? theme.colorScheme.primary  
                  : theme.colorScheme.outline.withOpacity(0.5),  
            ),  
          ),  
          child: Column(  
            mainAxisAlignment: MainAxisAlignment.center,  
            children: [  
              Text(  
                category.icon,  
                style: const TextStyle(fontSize: 24),  
              ),  
              const SizedBox(height: 4),  
              Text(  
                category.name,  
                style: theme.textTheme.labelSmall?.copyWith(  
                  color: isSelected  
                      ? theme.colorScheme.primary  
                      : theme.colorScheme.onSurface,  
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,  
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