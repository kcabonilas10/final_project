import 'package:flutter/material.dart';  
import 'package:provider/provider.dart';  
import '../../providers/auth_provider.dart';  
import '../../widgets/custom_button.dart';  

class ForgotPasswordScreen extends StatefulWidget {  
  const ForgotPasswordScreen({super.key});  

  @override  
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();  
}  

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {  
  final _formKey = GlobalKey<FormState>();  
  final _emailController = TextEditingController();  
  bool _isLoading = false;  
  String? _errorMessage;  

  @override  
  void dispose() {  
    _emailController.dispose();  
    super.dispose();  
  }  

  Future<void> _resetPassword() async {  
    if (!_formKey.currentState!.validate()) return;  

    setState(() {  
      _isLoading = true;  
      _errorMessage = null;  
    });  

    try {  
      await context.read<AuthProvider>().sendPasswordResetEmail(  
        _emailController.text.trim(),  
      );  

      if (mounted) {  
        ScaffoldMessenger.of(context).showSnackBar(  
          const SnackBar(  
            content: Text('Password reset email sent. Please check your inbox.'),  
            backgroundColor: Colors.green,  
          ),  
        );  
        Navigator.of(context).pop();  
      }  
    } catch (e) {  
      setState(() {  
        _errorMessage = e.toString();  
      });  
    } finally {  
      if (mounted) {  
        setState(() {  
          _isLoading = false;  
        });  
      }  
    }  
  }  

  @override  
  Widget build(BuildContext context) {  
    return Scaffold(  
      appBar: AppBar(  
        title: const Text('Reset Password'),  
      ),  
      body: SafeArea(  
        child: SingleChildScrollView(  
          padding: const EdgeInsets.all(16.0),  
          child: Form(  
            key: _formKey,  
            child: Column(  
              crossAxisAlignment: CrossAxisAlignment.stretch,  
              children: [  
                const SizedBox(height: 32),  
                
                // Icon and Title  
                Icon(  
                  Icons.lock_reset,  
                  size: 64,  
                  color: Theme.of(context).primaryColor,  
                ),  
                const SizedBox(height: 16),  
                Text(  
                  'Forgot Password?',  
                  style: Theme.of(context).textTheme.headlineSmall,  
                  textAlign: TextAlign.center,  
                ),  
                const SizedBox(height: 8),  
                Text(  
                  'Enter your email address and we\'ll send you instructions to reset your password.',  
                  style: Theme.of(context).textTheme.bodyMedium,  
                  textAlign: TextAlign.center,  
                ),  
                const SizedBox(height: 32),  

                // Email TextField  
                TextFormField(  
                  controller: _emailController,  
                  keyboardType: TextInputType.emailAddress,  
                  decoration: InputDecoration(  
                    labelText: 'Email',  
                    hintText: 'Enter your email address',  
                    prefixIcon: const Icon(Icons.email),  
                    border: OutlineInputBorder(  
                      borderRadius: BorderRadius.circular(12),  
                    ),  
                    enabledBorder: OutlineInputBorder(  
                      borderRadius: BorderRadius.circular(12),  
                      borderSide: BorderSide(  
                        color: Theme.of(context).primaryColor.withOpacity(0.3),  
                      ),  
                    ),  
                  ),  
                  validator: (value) {  
                    if (value == null || value.isEmpty) {  
                      return 'Please enter your email';  
                    }  
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')  
                        .hasMatch(value)) {  
                      return 'Please enter a valid email';  
                    }  
                    return null;  
                  },  
                ),  
                const SizedBox(height: 16),  

                // Error Message  
                if (_errorMessage != null)  
                  Padding(  
                    padding: const EdgeInsets.only(bottom: 16),  
                    child: Text(  
                      _errorMessage!,  
                      style: TextStyle(  
                        color: Theme.of(context).colorScheme.error,  
                        fontSize: 14,  
                      ),  
                      textAlign: TextAlign.center,  
                    ),  
                  ),  

                // Submit Button  
                CustomButton(  
                  text: 'Send Reset Link',  
                  onPressed: _resetPassword,  
                  isLoading: _isLoading,  
                ),  
                
                // Back to Login  
                const SizedBox(height: 16),  
                TextButton(  
                  onPressed: () => Navigator.of(context).pop(),  
                  child: const Text('Back to Login'),  
                ),  
              ],  
            ),  
          ),  
        ),  
      ),  
    );  
  }  
}