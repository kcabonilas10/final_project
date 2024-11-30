import 'package:firebase_auth/firebase_auth.dart';  
import 'package:flutter/material.dart';  

class AuthProvider with ChangeNotifier {  
  final FirebaseAuth _auth = FirebaseAuth.instance;  
  User? _user;  
  bool _isLoading = false;  

  bool get isAuthenticated => _user != null;  
  User? get user => _user;  
  bool get isLoading => _isLoading;  

  AuthProvider() {  
    _auth.authStateChanges().listen((User? user) {  
      _user = user;  
      notifyListeners();  
    });  
  }  

  Future<void> verifyPhoneNumber({  
    required String phoneNumber,  
    required Function(String) onCodeSent,  
    required Function(String) onError,  
  }) async {  
    try {  
      _isLoading = true;  
      notifyListeners();  

      await _auth.verifyPhoneNumber(  
        phoneNumber: phoneNumber,  
        verificationCompleted: (PhoneAuthCredential credential) async {  
          await _auth.signInWithCredential(credential);  
        },  
        verificationFailed: (FirebaseAuthException e) {  
          onError(e.message ?? 'An error occurred');  
        },  
        codeSent: (String verificationId, int? resendToken) {  
          onCodeSent(verificationId);  
        },  
        codeAutoRetrievalTimeout: (String verificationId) {},  
      );  
    } catch (e) {  
      onError(e.toString());  
    } finally {  
      _isLoading = false;  
      notifyListeners();  
    }  
  }  

  Future<void> verifyOTP({  
    required String verificationId,  
    required String otp,  
    required Function(String) onError,  
  }) async {  
    try {  
      _isLoading = true;  
      notifyListeners();  

      PhoneAuthCredential credential = PhoneAuthProvider.credential(  
        verificationId: verificationId,  
        smsCode: otp,  
      );  

      await _auth.signInWithCredential(credential);  
    } catch (e) {  
      onError(e.toString());  
    } finally {  
      _isLoading = false;  
      notifyListeners();  
    }  
  }  

  Future<void> sendPasswordResetEmail({  
    required String email,  
    required Function(String) onSuccess,  
    required Function(String) onError,  
  }) async {  
    try {  
      _isLoading = true;  
      notifyListeners();  

      await _auth.sendPasswordResetEmail(email: email);  
      onSuccess('Password reset email sent successfully');  
    } on FirebaseAuthException catch (e) {  
      switch (e.code) {  
        case 'user-not-found':  
          onError('No user found with this email');  
          break;  
        case 'invalid-email':  
          onError('Invalid email address');  
          break;  
        default:  
          onError(e.message ?? 'An error occurred');  
      }  
    } catch (e) {  
      onError(e.toString());  
    } finally {  
      _isLoading = false;  
      notifyListeners();  
    }  
  }  

  Future<void> signIn({  
    required String email,  
    required String password,  
    required Function(String) onSuccess,  
    required Function(String) onError,  
  }) async {  
    try {  
      _isLoading = true;  
      notifyListeners();  

      await _auth.signInWithEmailAndPassword(  
        email: email,  
        password: password,  
      );  
      onSuccess('Successfully logged in');  
    } on FirebaseAuthException catch (e) {  
      switch (e.code) {  
        case 'user-not-found':  
          onError('No user found with this email');  
          break;  
        case 'wrong-password':  
          onError('Wrong password');  
          break;  
        case 'invalid-email':  
          onError('Invalid email address');  
          break;  
        case 'user-disabled':  
          onError('This account has been disabled');  
          break;  
        default:  
          onError(e.message ?? 'An error occurred');  
      }  
    } catch (e) {  
      onError(e.toString());  
    } finally {  
      _isLoading = false;  
      notifyListeners();  
    }  
  }  

  Future<void> register({  
    required String email,  
    required String password,  
    required String name,  
    required Function(String) onSuccess,  
    required Function(String) onError,  
  }) async {  
    try {  
      _isLoading = true;  
      notifyListeners();  

      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(  
        email: email,  
        password: password,  
      );  

      await userCredential.user?.updateDisplayName(name);  
      await userCredential.user?.reload();  
      
      onSuccess('Registration successful');  
    } on FirebaseAuthException catch (e) {  
      switch (e.code) {  
        case 'weak-password':  
          onError('The password provided is too weak');  
          break;  
        case 'email-already-in-use':  
          onError('An account already exists for this email');  
          break;  
        case 'invalid-email':  
          onError('Invalid email address');  
          break;  
        default:  
          onError(e.message ?? 'An error occurred');  
      }  
    } catch (e) {  
      onError(e.toString());  
    } finally {  
      _isLoading = false;  
      notifyListeners();  
    }  
  }  

  Future<void> changePassword({  
    required String currentPassword,  
    required String newPassword,  
    required Function(String) onSuccess,  
    required Function(String) onError,  
  }) async {  
    try {  
      _isLoading = true;  
      notifyListeners();  

      final user = _auth.currentUser;  
      if (user == null) {  
        onError('No user is currently signed in');  
        return;  
      }  

      AuthCredential credential = EmailAuthProvider.credential(  
        email: user.email!,  
        password: currentPassword,  
      );  

      await user.reauthenticateWithCredential(credential);  
      await user.updatePassword(newPassword);  
      
      onSuccess('Password updated successfully');  
    } on FirebaseAuthException catch (e) {  
      switch (e.code) {  
        case 'wrong-password':  
          onError('Current password is incorrect');  
          break;  
        case 'weak-password':  
          onError('New password is too weak');  
          break;  
        case 'requires-recent-login':  
          onError('Please log in again before changing your password');  
          break;  
        default:  
          onError(e.message ?? 'An error occurred');  
      }  
    } catch (e) {  
      onError(e.toString());  
    } finally {  
      _isLoading = false;  
      notifyListeners();  
    }  
  }  

  Future<void> deleteAccount({  
    required String password,  
    required Function(String) onSuccess,  
    required Function(String) onError,  
  }) async {  
    try {  
      _isLoading = true;  
      notifyListeners();  

      final user = _auth.currentUser;  
      if (user == null) {  
        onError('No user is currently signed in');  
        return;  
      }  

      AuthCredential credential = EmailAuthProvider.credential(  
        email: user.email!,  
        password: password,  
      );  

      await user.reauthenticateWithCredential(credential);  
      await user.delete();  
      
      onSuccess('Account deleted successfully');  
    } on FirebaseAuthException catch (e) {  
      switch (e.code) {  
        case 'wrong-password':  
          onError('Password is incorrect');  
          break;  
        case 'requires-recent-login':  
          onError('Please log in again before deleting your account');  
          break;  
        default:  
          onError(e.message ?? 'An error occurred');  
      }  
    } catch (e) {  
      onError(e.toString());  
    } finally {  
      _isLoading = false;  
      notifyListeners();  
    }  
  }  

  Future<void> sendEmailVerification({  
    required Function(String) onSuccess,  
    required Function(String) onError,  
  }) async {  
    try {  
      _isLoading = true;  
      notifyListeners();  

      final user = _auth.currentUser;  
      if (user == null) {  
        onError('No user is currently signed in');  
        return;  
      }  

      await user.sendEmailVerification();  
      onSuccess('Verification email sent successfully');  
    } on FirebaseAuthException catch (e) {  
      onError(e.message ?? 'An error occurred');  
    } catch (e) {  
      onError(e.toString());  
    } finally {  
      _isLoading = false;  
      notifyListeners();  
    }  
  }  

  Future<void> signOut() async {  
    await _auth.signOut();  
  }  
}