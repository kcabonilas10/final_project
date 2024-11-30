import 'package:flutter/material.dart';  

class ResetPasswordScreen extends StatefulWidget {  
  const ResetPasswordScreen({super.key});  

  @override  
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();  
}  

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {  
  final _formKey = GlobalKey<FormState>();  
  final _passwordController = TextEditingController();  
  final _confirmPasswordController = TextEditingController();  
  bool _isPasswordVisible = false;  
  bool _isConfirmPasswordVisible = false;  

  @override  
  void dispose() {  
    _passwordController.dispose();  
    _confirmPasswordController.dispose();  
    super.dispose();  
  }  

  @override  
  Widget build(BuildContext context) {  
    return Scaffold(  
      appBar: AppBar(  
        title: const Text('Reset Password'),  
      ),  
      body: Padding(  
        padding: const EdgeInsets.all(24),  
        child: Form(  
          key: _formKey,  
          child: Column(  
            crossAxisAlignment: CrossAxisAlignment.stretch,  
            children: [  
              Text(  
                'Create New Password',  
                style: Theme.of(context).textTheme.headlineMedium,  
                textAlign: TextAlign.center,  
              ),  
              const SizedBox(height: 8),  
              Text(  
                'Your new password must be different from previous used passwords',  
                style: Theme.of(context).textTheme.bodyLarge,  
                textAlign: TextAlign.center,  
              ),  
              const SizedBox(height: 32),  
              TextFormField(  
                controller: _passwordController,  
                obscureText: !_isPasswordVisible,  
                decoration: InputDecoration(  
                  labelText: 'New Password',  
                  prefixIcon: const Icon(Icons.lock),  
                  suffixIcon: IconButton(  
                    icon: Icon(  
                      _isPasswordVisible  
                          ? Icons.visibility_off  
                          : Icons.visibility,  
                    ),  
                    onPressed: () {  
                      setState(() {  
                        _isPasswordVisible = !_isPasswordVisible;  
                      });  
                    },  
                  ),  
                ),  
                validator: (value) {  
                  if (value == null || value.isEmpty) {  
                    return 'Please enter your new password';  
                  }  
                  if (value.length < 6) {  
                    return 'Password must be at least 6 characters';  
                  }  
                  return null;  
                },  
              ),  
              const SizedBox(height: 16),  
              TextFormField(  
                controller: _confirmPasswordController,  
                obscureText: !_isConfirmPasswordVisible,  
                decoration: InputDecoration(  
                  labelText: 'Confirm New Password',  
                  prefixIcon: const Icon(Icons.lock_outline),  
                  suffixIcon: IconButton(  
                    icon: Icon(  
                      _isConfirmPasswordVisible  
                          ? Icons.visibility_off  
                          : Icons.visibility,  
                    ),  
                    onPressed: () {  
                      setState(() {  
                        _isConfirmPasswordVisible = !_isConfirmPasswordVisible;  
                      });  
                    },  
                  ),  
                ),  
                validator: (value) {  
                  if (value == null || value.isEmpty) {  
                    return 'Please confirm your new password';  
                  }  
                  if (value != _passwordController.text) {  
                    return 'Passwords do not match';  
                  }  
                  return null;  
                },  
              ),  
              const SizedBox(height: 32),  
              FilledButton(  
                onPressed: () {  
                  if (_formKey.currentState?.validate() ?? false) {  
                    // Implement password reset  
                    Navigator.of(context).pushReplacementNamed('/login');  
                  }  
                },  
                child: const Text('Reset Password'),  
              ),  
            ],  
          ),  
        ),  
      ),  
    );  
  }  
}