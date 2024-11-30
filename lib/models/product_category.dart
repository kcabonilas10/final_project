// lib/models/product_category.dart  
class ProductCategory {  
  final String id;  
  final String name;  
  final String icon;  

  const ProductCategory({  
    required this.id,  
    required this.name,  
    required this.icon,  
  });  

  ProductCategory copyWith({  
    String? id,  
    String? name,  
    String? icon,  
  }) {  
    return ProductCategory(  
      id: id ?? this.id,  
      name: name ?? this.name,  
      icon: icon ?? this.icon,  
    );  
  }  

  @override  
  bool operator ==(Object other) =>  
      identical(this, other) ||  
      other is ProductCategory &&  
          runtimeType == other.runtimeType &&  
          id == other.id &&  
          name == other.name &&  
          icon == other.icon;  

  @override  
  int get hashCode => id.hashCode ^ name.hashCode ^ icon.hashCode;  

  @override  
  String toString() => 'ProductCategory(id: $id, name: $name, icon: $icon)';  
}