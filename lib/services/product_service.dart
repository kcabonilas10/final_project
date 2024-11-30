// lib/services/product_service.dart  
import 'package:flutter/foundation.dart';  
import '../models/product.dart';  
import '../models/category.dart';  
import 'mock_api.dart';  

class ProductService with ChangeNotifier {  
  List<Product> _products = [];  
  List<ProductCategory> _categories = [];  
  String? _selectedCategoryId;  
  bool _isLoading = false;  
  String _error = '';  

  // Getters  
  List<Product> get products => _selectedCategoryId == null  
      ? [..._products]  
      : _products  
          .where((product) => product.categoryId == _selectedCategoryId)  
          .toList();  

  List<ProductCategory> get categories => [..._categories];  
  String? get selectedCategoryId => _selectedCategoryId;  
  bool get isLoading => _isLoading;  
  String get error => _error;  
  List<Product> get featuredProducts =>  
      _products.where((product) => product.isFeatured).toList();  

  // Initialize data  
  Future<void> loadInitialData() async {  
    _isLoading = true;  
    _error = '';  
    notifyListeners();  

    try {  
      final categoriesResult = MockApi.getCategories();  
      final productsResult = MockApi.getProducts();  

      final results = await Future.wait([categoriesResult, productsResult]);  
      
      _categories = results[0] as List<ProductCategory>;  
      _products = results[1] as List<Product>;  
    } catch (e) {  
      _error = 'Failed to load data: ${e.toString()}';  
    } finally {  
      _isLoading = false;  
      notifyListeners();  
    }  
  }  

  // Filter products by category  
  void filterByCategory(String? categoryId) {  
    _selectedCategoryId = categoryId;  
    notifyListeners();  
  }  

  // Search products  
  Future<List<Product>> searchProducts(String query) async {  
    if (query.isEmpty) return [];  

    try {  
      final results = await MockApi.searchProducts(query);  
      if (_selectedCategoryId != null) {  
        return results  
            .where((product) => product.categoryId == _selectedCategoryId)  
            .toList();  
      }  
      return results;  
    } catch (e) {  
      _error = 'Search failed: ${e.toString()}';  
      notifyListeners();  
      return [];  
    }  
  }  

  // Get product by ID  
  Future<Product?> getProductById(String id) async {  
    try {  
      return await MockApi.getProductById(id);  
    } catch (e) {  
      _error = 'Failed to get product: ${e.toString()}';  
      notifyListeners();  
      return null;  
    }  
  }  

  // Get category by ID  
  ProductCategory? getCategoryById(String id) {  
    try {  
      return _categories.firstWhere((category) => category.id == id);  
    } catch (_) {  
      return null;  
    }  
  }  

  // Get related products  
  Future<List<Product>> getRelatedProducts(String productId) async {  
    try {  
      return await MockApi.getRelatedProducts(productId);  
    } catch (e) {  
      _error = 'Failed to get related products: ${e.toString()}';  
      notifyListeners();  
      return [];  
    }  
  }  

  // Get top rated products  
  Future<List<Product>> getTopRatedProducts({int limit = 10}) async {  
    try {  
      return await MockApi.getTopRatedProducts(limit: limit);  
    } catch (e) {  
      _error = 'Failed to get top rated products: ${e.toString()}';  
      notifyListeners();  
      return [];  
    }  
  }  

  // Clear error  
  void clearError() {  
    _error = '';  
    notifyListeners();  
  }  

  // Refresh data  
  Future<void> refresh() async {  
    await loadInitialData();  
  }  
}