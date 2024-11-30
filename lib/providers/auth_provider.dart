// lib/providers/auth_provider.dart  
import 'package:flutter/foundation.dart';  
import 'package:firebase_auth/firebase_auth.dart';  
import 'package:cloud_firestore/cloud_firestore.dart';  

class AuthProvider with ChangeNotifier {  
  final FirebaseAuth _auth = FirebaseAuth.instance;  
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;  

  bool _loading = false;  
  String? _error;  
  User? _user;  

  // Getters  
  bool get loading => _loading;  
  String? get error => _error;  
  User? get user => _user ?? _auth.currentUser;  
  bool get isAuthenticated => user != null;  

  AuthProvider() {  
    _auth.authStateChanges().listen((User? user) {  
      _user = user;  
      notifyListeners();  
    });  
  }  

  // Register new user  
  Future<UserCredential> register({  
    required String name,  
    required String email,  
    required String password,  
  }) async {  
    try {  
      _loading = true;  
      _error = null;  
      notifyListeners();  

      // Create user with email and password  
      final UserCredential userCredential =   
          await _auth.createUserWithEmailAndPassword(  
        email: email.trim(),  
        password: password,  
      );  

      // If user creation is successful, add user details to Firestore  
      if (userCredential.user != null) {  
        await _firestore.collection('users').doc(userCredential.user!.uid).set({  
          'name': name.trim(),  
          'email': email.trim(),  
          'createdAt': FieldValue.serverTimestamp(),  
          'updatedAt': FieldValue.serverTimestamp(),  
        });  

        // Update user profile  
        await userCredential.user!.updateDisplayName(name.trim());  
        
        // Send email verification  
        await userCredential.user!.sendEmailVerification();  
      }  

      return userCredential;  

    } on FirebaseAuthException catch (e) {  
      String errorMessage;  
      
      switch (e.code) {  
        case 'weak-password':  
          errorMessage = 'The password provided is too weak.';  
          break;  
        case 'email-already-in-use':  
          errorMessage = 'An account already exists for that email.';  
          break;  
        case 'invalid-email':  
          errorMessage = 'The email address is not valid.';  
          break;  
        case 'operation-not-allowed':  
          errorMessage = 'Email/password accounts are not enabled.';  
          break;  
        default:  
          errorMessage = 'An error occurred during registration. Please try again.';  
      }  
      
      _error = errorMessage;  
      throw errorMessage;  
    } catch (e) {  
      _error = e.toString();  
      throw _error!;  
    } finally {  
      _loading = false;  
      notifyListeners();  
    }  
  }  

  // Sign in existing user  
  Future<UserCredential> signIn({  
    required String email,  
    required String password,  
  }) async {  
    try {  
      _loading = true;  
      _error = null;  
      notifyListeners();  

      final UserCredential userCredential =   
          await _auth.signInWithEmailAndPassword(  
        email: email.trim(),  
        password: password,  
      );  

      // Update last login timestamp  
      if (userCredential.user != null) {  
        await _firestore.collection('users').doc(userCredential.user!.uid).update({  
          'lastLoginAt': FieldValue.serverTimestamp(),  
        });  
      }  

      return userCredential;  

    } on FirebaseAuthException catch (e) {  
      String errorMessage;  
      
      switch (e.code) {  
        case 'user-not-found':  
          errorMessage = 'No user found for that email.';  
          break;  
        case 'wrong-password':  
          errorMessage = 'Wrong password provided.';  
          break;  
        case 'user-disabled':  
          errorMessage = 'This account has been disabled.';  
          break;  
        case 'invalid-email':  
          errorMessage = 'The email address is not valid.';  
          break;  
        case 'too-many-requests':  
          errorMessage = 'Too many failed login attempts. Please try again later.';  
          break;  
        default:  
          errorMessage = 'An error occurred during sign in. Please try again.';  
      }  
      
      _error = errorMessage;  
      throw errorMessage;  
    } catch (e) {  
      _error = e.toString();  
      throw _error!;  
    } finally {  
      _loading = false;  
      notifyListeners();  
    }  
  }  

  // Sign out  
  Future<void> signOut() async {  
    try {  
      _loading = true;  
      _error = null;  
      notifyListeners();  

      await _auth.signOut();  
      _user = null;  

    } catch (e) {  
      _error = e.toString();  
      throw _error!;  
    } finally {  
      _loading = false;  
      notifyListeners();  
    }  
  }  

  // Password reset  
  Future<void> sendPasswordResetEmail(String email) async {  
    try {  
      _loading = true;  
      _error = null;  
      notifyListeners();  

      await _auth.sendPasswordResetEmail(email: email.trim());  

    } on FirebaseAuthException catch (e) {  
      String errorMessage;  
      
      switch (e.code) {  
        case 'invalid-email':  
          errorMessage = 'The email address is not valid.';  
          break;  
        case 'user-not-found':  
          errorMessage = 'No user found for that email.';  
          break;  
        default:  
          errorMessage = 'An error occurred. Please try again.';  
      }  
      
      _error = errorMessage;  
      throw errorMessage;  
    } catch (e) {  
      _error = e.toString();  
      throw _error!;  
    } finally {  
      _loading = false;  
      notifyListeners();  
    }  
  }  

  // Update user profile  
  Future<void> updateProfile({String? name, String? photoURL}) async {  
    try {  
      _loading = true;  
      _error = null;  
      notifyListeners();  

      if (_auth.currentUser == null) {  
        throw 'No authenticated user found';  
      }  

      // Update Firebase Auth profile  
      await _auth.currentUser!.updateProfile(  
        displayName: name,  
        photoURL: photoURL,  
      );  

      // Update Firestore user document  
      final updates = <String, dynamic>{  
        'updatedAt': FieldValue.serverTimestamp(),  
      };  
      
      if (name != null) updates['name'] = name;  
      if (photoURL != null) updates['photoURL'] = photoURL;  

      await _firestore  
          .collection('users')  
          .doc(_auth.currentUser!.uid)  
          .update(updates);  

    } catch (e) {  
      _error = e.toString();  
      throw _error!;  
    } finally {  
      _loading = false;  
      notifyListeners();  
    }  
  }  

  // Change password  
  Future<void> changePassword(String newPassword) async {  
    try {  
      _loading = true;  
      _error = null;  
      notifyListeners();  

      if (_auth.currentUser == null) {  
        throw 'No authenticated user found';  
      }  

      await _auth.currentUser!.updatePassword(newPassword);  

    } on FirebaseAuthException catch (e) {  
      String errorMessage;  
      
      switch (e.code) {  
        case 'weak-password':  
          errorMessage = 'The password provided is too weak.';  
          break;  
        case 'requires-recent-login':  
          errorMessage = 'Please sign in again to change your password.';  
          break;  
        default:  
          errorMessage = 'An error occurred. Please try again.';  
      }  
      
      _error = errorMessage;  
      throw errorMessage;  
    } catch (e) {  
      _error = e.toString();  
      throw _error!;  
    } finally {  
      _loading = false;  
      notifyListeners();  
    }  
  }  

  // Send email verification  
  Future<void> sendEmailVerification() async {  
    try {  
      _loading = true;  
      _error = null;  
      notifyListeners();  

      if (_auth.currentUser == null) {  
        throw 'No authenticated user found';  
      }  

      await _auth.currentUser!.sendEmailVerification();  

    } catch (e) {  
      _error = e.toString();  
      throw _error!;  
    } finally {  
      _loading = false;  
      notifyListeners();  
    }  
  }  

  // Delete account  
  Future<void> deleteAccount() async {  
    try {  
      _loading = true;  
      _error = null;  
      notifyListeners();  

      if (_auth.currentUser == null) {  
        throw 'No authenticated user found';  
      }  

      // Delete user data from Firestore  
      await _firestore.collection('users').doc(_auth.currentUser!.uid).delete();  

      // Delete user account  
      await _auth.currentUser!.delete();  
      _user = null;  

    } on FirebaseAuthException catch (e) {  
      String errorMessage;  
      
      switch (e.code) {  
        case 'requires-recent-login':  
          errorMessage = 'Please sign in again to delete your account.';  
          break;  
        default:  
          errorMessage = 'An error occurred. Please try again.';  
      }  
      
      _error = errorMessage;  
      throw errorMessage;  
    } catch (e) {  
      _error = e.toString();  
      throw _error!;  
    } finally {  
      _loading = false;  
      notifyListeners();  
    }  
  }  
}