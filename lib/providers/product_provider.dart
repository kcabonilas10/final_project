// lib/providers/product_provider.dart  
import 'package:flutter/foundation.dart';  
import '../models/product.dart';  
import '../models/category.dart';  

class ProductProvider with ChangeNotifier {  
  List<Product> _products = [];  
  List<ProductCategory> _categories = [];  
  String? _selectedCategory;  
  String _error = '';  
  bool _isLoading = false;  

  List<Product> get products => _selectedCategory == null   
    ? [..._products]  
    : _products.where((product) => product.categoryId == _selectedCategory).toList();  
    
  List<ProductCategory> get categories => [..._categories];  
  String? get selectedCategory => _selectedCategory;  
  String get error => _error;  
  bool get isLoading => _isLoading;  

  Future<void> loadProducts() async {  
    _isLoading = true;  
    _error = '';  
    notifyListeners();  

    try {  
      // Simulate API call  
      await Future.delayed(const Duration(seconds: 1));  
      
      // Initialize categories  
      _categories = [  
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

      // Initialize products with categories  
      _products = [  
        const Product(  
          id: '1',  
          name: 'Laptop',  
          imageUrl: 'https://example.com/laptop.jpg',  
          price: 999.99,  
          description: 'Powerful laptop for all your needs',  
          categoryId: 'electronics',  
        ),  
        const Product(  
          id: '2',  
          name: 'T-Shirt',  
          imageUrl: 'https://example.com/tshirt.jpg',  
          price: 19.99,  
          description: 'Comfortable cotton t-shirt',  
          categoryId: 'clothing',  
        ),  
        // Add more sample products  
      ];  
    } catch (e) {  
      _error = e.toString();  
    } finally {  
      _isLoading = false;  
      notifyListeners();  
    }  
  }  

  void filterByCategory(String? categoryId) {  
    _selectedCategory = categoryId;  
    notifyListeners();  
  }  

  List<Product> searchProducts(String query) {  
    final filteredProducts = _selectedCategory == null   
        ? _products   
        : _products.where((product) => product.categoryId == _selectedCategory).toList();  
        
    return filteredProducts.where((product) =>  
      product.name.toLowerCase().contains(query.toLowerCase())  
    ).toList();  
  }  

  Product? getProductById(String id) {  
    try {  
      return _products.firstWhere((product) => product.id == id);  
    } catch (_) {  
      return null;  
    }  
  }  

  ProductCategory? getCategoryById(String id) {  
    try {  
      return _categories.firstWhere((category) => category.id == id);  
    } catch (_) {  
      return null;  
    }  
  }  
}