// lib/widgets/category_grid.dart  
import 'package:flutter/material.dart';  

class CategoryItem {  
  final String id;  
  final String title;  
  final IconData icon;  
  final Color color;  

  CategoryItem({  
    required this.id,  
    required this.title,  
    required this.icon,  
    required this.color,  
  });  
}  

class CategoryGrid extends StatelessWidget {  
  final List<CategoryItem> categories = [  
    CategoryItem(  
      id: 'c1',  
      title: 'Electronics',  
      icon: Icons.devices,  
      color: Colors.blue,  
    ),  
    CategoryItem(  
      id: 'c2',  
      title: 'Fashion',  
      icon: Icons.shopping_bag,  
      color: Colors.pink,  
    ),  
    CategoryItem(  
      id: 'c3',  
      title: 'Home',  
      icon: Icons.home,  
      color: Colors.green,  
    ),  
    CategoryItem(  
      id: 'c4',  
      title: 'Beauty',  
      icon: Icons.face,  
      color: Colors.purple,  
    ),  
    CategoryItem(  
      id: 'c5',  
      title: 'Sports',  
      icon: Icons.sports_basketball,  
      color: Colors.orange,  
    ),  
    CategoryItem(  
      id: 'c6',  
      title: 'Books',  
      icon: Icons.book,  
      color: Colors.brown,  
    ),  
    CategoryItem(  
      id: 'c7',  
      title: 'Toys',  
      icon: Icons.toys,  
      color: Colors.red,  
    ),  
    CategoryItem(  
      id: 'c8',  
      title: 'More',  
      icon: Icons.more_horiz,  
      color: Colors.grey,  
    ),  
  ];  

  CategoryGrid({super.key});  

  @override  
  Widget build(BuildContext context) {  
    return GridView.builder(  
      padding: const EdgeInsets.all(16),  
      physics: const NeverScrollableScrollPhysics(),  
      shrinkWrap: true,  
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(  
        crossAxisCount: 4,  
        childAspectRatio: 1,  
        crossAxisSpacing: 16,  
        mainAxisSpacing: 16,  
      ),  
      itemCount: categories.length,  
      itemBuilder: (ctx, i) {  
        return CategoryGridItem(category: categories[i]);  
      },  
    );  
  }  
}  

class CategoryGridItem extends StatelessWidget {  
  final CategoryItem category;  

  const CategoryGridItem({  
    super.key,  
    required this.category,  
  });  

  @override  
  Widget build(BuildContext context) {  
    return InkWell(  
      onTap: () {  
        // Navigate to category screen  
        // Navigator.of(context).pushNamed(  
        //   CategoryScreen.routeName,  
        //   arguments: category.id,  
        // );  
      },  
      borderRadius: BorderRadius.circular(16),  
      child: Column(  
        mainAxisAlignment: MainAxisAlignment.center,  
        children: [  
          Container(  
            padding: const EdgeInsets.all(12),  
            decoration: BoxDecoration(  
              color: category.color.withOpacity(0.1),  
              shape: BoxShape.circle,  
            ),  
            child: Icon(  
              category.icon,  
              color: category.color,  
              size: 24,  
            ),  
          ),  
          const SizedBox(height: 4),  
          Text(  
            category.title,  
            style: Theme.of(context).textTheme.bodySmall,  
            textAlign: TextAlign.center,  
            maxLines: 1,  
            overflow: TextOverflow.ellipsis,  
          ),  
        ],  
      ),  
    );  
  }  
}