// lib/services/mock_api.dart  
import '../models/product.dart';  
import '../models/category.dart';  

class MockApi {  
  static final List<Product> _products = [  
    const Product(  
      id: '1',  
      name: 'MacBook Pro',  
      imageUrl: 'assets/images/products/macbook.jpg',  
      price: 1299.99,  
      description: 'Powerful laptop for professionals',  
      categoryId: 'electronics',  
      isFeatured: true,  
      rating: 4.8,  
      reviewCount: 256,  
    ),  
    const Product(  
      id: '2',  
      name: 'Nike Air Max',  
      imageUrl: 'assets/images/products/nike.jpg',  
      price: 129.99,  
      description: 'Comfortable running shoes',  
      categoryId: 'sports',  
      rating: 4.5,  
      reviewCount: 128,  
    ),  
    const Product(  
      id: '3',  
      name: 'iPhone 13 Pro',  
      imageUrl: 'assets/images/products/iphone.jpg',  
      price: 999.99,  
      description: 'Latest iPhone with pro camera system',  
      categoryId: 'electronics',  
      isFeatured: true,  
      rating: 4.9,  
      reviewCount: 512,  
    ),  
    const Product(  
      id: '4',  
      name: 'Coffee Maker',  
      imageUrl: 'assets/images/products/coffee.jpg',  
      price: 79.99,  
      description: 'Automatic drip coffee maker',  
      categoryId: 'home',  
      rating: 4.3,  
      reviewCount: 89,  
    ),  
  ];  

  static final List<ProductCategory> _categories = [  
    const ProductCategory(  
      id: 'electronics',  
      name: 'Electronics',  
      icon: '💻',  
    ),  
    const ProductCategory(  
      id: 'clothing',  
      name: 'Clothing',  
      icon: '👕',  
    ),  
    const ProductCategory(  
      id: 'books',  
      name: 'Books',  
      icon: '📚',  
    ),  
    const ProductCategory(  
      id: 'sports',  
      name: 'Sports',  
      icon: '⚽',  
    ),  
    const ProductCategory(  
      id: 'home',  
      name: 'Home',  
      icon: '🏠',  
    ),  
  ];  

  // Simulate API delay  
  static Future<void> _delay() async {  
    await Future.delayed(const Duration(milliseconds: 800));  
  }  

  // Get all products  
  static Future<List<Product>> getProducts() async {  
    await _delay();  
    return [..._products];  
  }  

  // Get featured products  
  static Future<List<Product>> getFeaturedProducts() async {  
    await _delay();  
    return _products.where((product) => product.isFeatured).toList();  
  }  

  // Get products by category  
  static Future<List<Product>> getProductsByCategory(String categoryId) async {  
    await _delay();  
    return _products.where((product) => product.categoryId == categoryId).toList();  
  }  

  // Get product by ID  
  static Future<Product?> getProductById(String id) async {  
    await _delay();  
    try {  
      return _products.firstWhere((product) => product.id == id);  
    } catch (_) {  
      return null;  
    }  
  }  

  // Search products  
  static Future<List<Product>> searchProducts(String query) async {  
    await _delay();  
    final lowercaseQuery = query.toLowerCase();  
    return _products.where((product) {  
      final name = product.name.toLowerCase();  
      final description = product.description?.toLowerCase() ?? '';  
      
      // Get category name for the product  
      final categoryName = _categories  
          .firstWhere(  
            (cat) => cat.id == product.categoryId,  
            orElse: () => const ProductCategory(  
              id: '',  
              name: '',  
              icon: '',  
            ),  
          )  
          .name  
          .toLowerCase();  

      return name.contains(lowercaseQuery) ||  
          description.contains(lowercaseQuery) ||  
          categoryName.contains(lowercaseQuery);  
    }).toList();  
  }  

  // Get all categories  
  static Future<List<ProductCategory>> getCategories() async {  
    await _delay();  
    return [..._categories];  
  }  

  // Get category by ID  
  static Future<ProductCategory?> getCategoryById(String id) async {  
    await _delay();  
    try {  
      return _categories.firstWhere((category) => category.id == id);  
    } catch (_) {  
      return null;  
    }  
  }  

  // Get top rated products  
  static Future<List<Product>> getTopRatedProducts({int limit = 10}) async {  
    await _delay();  
    return [..._products]  
      ..sort((a, b) => b.rating.compareTo(a.rating))  
      ..take(limit)  
      .toList();  
  }  

  // Get related products  
  static Future<List<Product>> getRelatedProducts(String productId) async {  
    await _delay();  
    final product = _products.firstWhere(  
      (p) => p.id == productId,  
      orElse: () => _products.first,  
    );  

    return _products  
        .where((p) =>  
            p.id != productId && p.categoryId == product.categoryId)  
        .take(5)  
        .toList();  
  }  

  // Get products by price range  
  static Future<List<Product>> getProductsByPriceRange({  
    required double minPrice,  
    required double maxPrice,  
  }) async {  
    await _delay();  
    return _products  
        .where((product) =>  
            product.price >= minPrice && product.price <= maxPrice)  
        .toList();  
  }  
}  