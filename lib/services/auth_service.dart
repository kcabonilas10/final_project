import 'dart:async';  
import '../models/user.dart';  

class AuthService {  
  final _authStateController = StreamController<User?>.broadcast();  
  User? _currentUser;  

  Stream<User?> get authStateChanges => _authStateController.stream;  
  User? get currentUser => _currentUser;  

  Future<User> signInWithEmailAndPassword(String email, String password) async {  
    try {  
      // Simulate network delay  
      await Future.delayed(const Duration(seconds: 1));  
      
      // Simulate successful login  
      final user = User(  
        id: 'user_${DateTime.now().millisecondsSinceEpoch}',  
        email: email,  
        displayName: email.split('@')[0],  
        emailVerified: false,  
      );  
      
      _currentUser = user;  
      _authStateController.add(user);  
      return user;  
    } catch (e) {  
      throw Exception('Failed to sign in: $e');  
    }  
  }  

  Future<User> createUserWithEmailAndPassword(String email, String password) async {  
    try {  
      // Simulate network delay  
      await Future.delayed(const Duration(seconds: 1));  
      
      // Simulate user creation  
      final user = User(  
        id: 'user_${DateTime.now().millisecondsSinceEpoch}',  
        email: email,  
        displayName: email.split('@')[0],  
        emailVerified: false,  
      );  
      
      _currentUser = user;  
      _authStateController.add(user);  
      return user;  
    } catch (e) {  
      throw Exception('Failed to create user: $e');  
    }  
  }  

  Future<void> signOut() async {  
    try {  
      await Future.delayed(const Duration(milliseconds: 500));  
      _currentUser = null;  
      _authStateController.add(null);  
    } catch (e) {  
      throw Exception('Failed to sign out: $e');  
    }  
  }  

  Future<void> verifyEmail() async {  
    try {  
      if (_currentUser == null) throw Exception('No user signed in');  
      
      await Future.delayed(const Duration(seconds: 1));  
      _currentUser = _currentUser!.copyWith(emailVerified: true);  
      _authStateController.add(_currentUser);  
    } catch (e) {  
      throw Exception('Failed to verify email: $e');  
    }  
  }  

  Future<void> updateProfile({String? displayName, String? photoURL}) async {  
    try {  
      if (_currentUser == null) throw Exception('No user signed in');  
      
      await Future.delayed(const Duration(seconds: 1));  
      _currentUser = _currentUser!.copyWith(  
        displayName: displayName ?? _currentUser!.displayName,  
        photoURL: photoURL ?? _currentUser!.photoURL,  
      );  
      _authStateController.add(_currentUser);  
    } catch (e) {  
      throw Exception('Failed to update profile: $e');  
    }  
  }  

  Future<void> sendPasswordResetEmail(String email) async {  
    try {  
      await Future.delayed(const Duration(seconds: 1));  
      // Simulate sending password reset email  
    } catch (e) {  
      throw Exception('Failed to send password reset email: $e');  
    }  
  }  

  void dispose() {  
    _authStateController.close();  
  }  
}