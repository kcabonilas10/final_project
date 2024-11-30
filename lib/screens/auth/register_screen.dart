import 'package:flutter/material.dart';  
import 'package:provider/provider.dart';  
import '../../providers/auth_provider.dart';  

class RegisterScreen extends StatefulWidget {  
  static const routeName = '/register';  

  const RegisterScreen({super.key});  

  @override  
  State<RegisterScreen> createState() => _RegisterScreenState();  
}  

class _RegisterScreenState extends State<RegisterScreen> {  
  final _formKey = GlobalKey<FormState>();  
  final _nameController = TextEditingController();  
  final _emailController = TextEditingController();  
  final _passwordController = TextEditingController();  
  final _confirmPasswordController = TextEditingController();  
  bool _obscurePassword = true;  
  bool _obscureConfirmPassword = true;  

  @override  
  Widget build(BuildContext context) {  
    return Scaffold(  
      appBar: AppBar(  
        title: const Text('Register'),  
      ),  
      body: SingleChildScrollView(  
        padding: const EdgeInsets.all(16.0),  
        child: Form(  
          key: _formKey,  
          child: Column(  
            crossAxisAlignment: CrossAxisAlignment.stretch,  
            children: [  
              TextFormField(  
                controller: _nameController,  
                decoration: const InputDecoration(  
                  labelText: 'Full Name',  
                  hintText: 'Enter your full name',  
                ),  
                textCapitalization: TextCapitalization.words,  
                validator: (value) {  
                  if (value == null || value.isEmpty) {  
                    return 'Please enter your name';  
                  }  
                  return null;  
                },  
              ),  
              const SizedBox(height: 16),  
              TextFormField(  
                controller: _emailController,  
                decoration: const InputDecoration(  
                  labelText: 'Email',  
                  hintText: 'Enter your email',  
                ),  
                keyboardType: TextInputType.emailAddress,  
                validator: (value) {  
                  if (value == null || value.isEmpty) {  
                    return 'Please enter your email';  
                  }  
                  if (!value.contains('@')) {  
                    return 'Please enter a valid email';  
                  }  
                  return null;  
                },  
              ),  
              const SizedBox(height: 16),  
              TextFormField(  
                controller: _passwordController,  
                decoration: InputDecoration(  
                  labelText: 'Password',  
                  hintText: 'Enter your password',  
                  suffixIcon: IconButton(  
                    icon: Icon(  
                      _obscurePassword ? Icons.visibility_off : Icons.visibility,  
                    ),  
                    onPressed: () {  
                      setState(() {  
                        _obscurePassword = !_obscurePassword;  
                      });  
                    },  
                  ),  
                ),  
                obscureText: _obscurePassword,  
                validator: (value) {  
                  if (value == null || value.isEmpty) {  
                    return 'Please enter a password';  
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
                decoration: InputDecoration(  
                  labelText: 'Confirm Password',  
                  hintText: 'Confirm your password',  
                  suffixIcon: IconButton(  
                    icon: Icon(  
                      _obscureConfirmPassword  
                          ? Icons.visibility_off  
                          : Icons.visibility,  
                    ),  
                    onPressed: () {  
                      setState(() {  
                        _obscureConfirmPassword = !_obscureConfirmPassword;  
                      });  
                    },  
                  ),  
                ),  
                obscureText: _obscureConfirmPassword,  
                validator: (value) {  
                  if (value == null || value.isEmpty) {  
                    return 'Please confirm your password';  
                  }  
                  if (value != _passwordController.text) {  
                    return 'Passwords do not match';  
                  }  
                  return null;  
                },  
              ),  
              const SizedBox(height: 24),  
              Consumer<AuthProvider>(  
                builder: (context, auth, _) {  
                  return FilledButton(  
                    onPressed: auth.isLoading  
                        ? null  
                        : () {  
                            if (_formKey.currentState!.validate()) {  
                              auth.register(  
                                email: _emailController.text,  
                                password: _passwordController.text,  
                                name: _nameController.text,  
                                onSuccess: (message) {  
                                  ScaffoldMessenger.of(context).showSnackBar(  
                                    SnackBar(content: Text(message)),  
                                  );  
                                  Navigator.of(context).pop();  
                                },  
                                onError: (error) {  
                                  ScaffoldMessenger.of(context).showSnackBar(  
                                    SnackBar(  
                                      content: Text(error),  
                                      backgroundColor: Colors.red,  
                                    ),  
                                  );  
                                },  
                              );  
                            }  
                          },  
                    child: auth.isLoading  
                        ? const SizedBox(  
                            width: 20,  
                            height: 20,  
                            child: CircularProgressIndicator(  
                              strokeWidth: 2,  
                              color: Colors.white,  
                            ),  
                          )  
                        : const Text('Register'),  
                  );  
                },  
              ),  
              const SizedBox(height: 16),  
              TextButton(  
                onPressed: () {  
                  Navigator.of(context).pop();  
                },  
                child: const Text('Already have an account? Login'),  
              ),  
            ],  
          ),  
        ),  
      ),  
    );  
  }  

  @override  
  void dispose() {  
    _nameController.dispose();  
    _emailController.dispose();  
    _passwordController.dispose();  
    _confirmPasswordController.dispose();  
    super.dispose();  
  }  
}