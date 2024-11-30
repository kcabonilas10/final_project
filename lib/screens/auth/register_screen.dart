import 'package:flutter/gestures.dart';  
import 'package:flutter/material.dart';  
import 'package:provider/provider.dart';  
import '../../providers/auth_provider.dart';  
import '../../widgets/custom_button.dart';  
import 'login_screen.dart';  
import 'privacy_policy_screen.dart';  
import 'terms_screen.dart';  

class RegisterScreen extends StatefulWidget {  
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
  
  bool _isLoading = false;  
  bool _obscurePassword = true;  
  bool _obscureConfirmPassword = true;  
  bool _acceptedTerms = false;  
  String? _errorMessage;  

  @override  
  void dispose() {  
    _nameController.dispose();  
    _emailController.dispose();  
    _passwordController.dispose();  
    _confirmPasswordController.dispose();  
    super.dispose();  
  }  

  Future<void> _register() async {  
    if (!_acceptedTerms) {  
      setState(() {  
        _errorMessage = 'Please accept the Terms of Service and Privacy Policy';  
      });  
      return;  
    }  

    if (!_formKey.currentState!.validate()) return;  

    setState(() {  
      _isLoading = true;  
      _errorMessage = null;  
    });  

    try {  
      await context.read<AuthProvider>().register(  
        name: _nameController.text.trim(),  
        email: _emailController.text.trim(),  
        password: _passwordController.text,  
      );  

      if (mounted) {  
        Navigator.of(context).pushReplacement(  
          MaterialPageRoute(builder: (_) => const LoginScreen()),  
        );  
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
        title: const Text('Create Account'),  
      ),  
      body: SafeArea(  
        child: SingleChildScrollView(  
          padding: const EdgeInsets.all(16.0),  
          child: Form(  
            key: _formKey,  
            child: Column(  
              crossAxisAlignment: CrossAxisAlignment.stretch,  
              children: [  
                // Name Field  
                TextFormField(  
                  controller: _nameController,  
                  decoration: InputDecoration(  
                    labelText: 'Full Name',  
                    prefixIcon: const Icon(Icons.person),  
                    border: OutlineInputBorder(  
                      borderRadius: BorderRadius.circular(12),  
                    ),  
                  ),  
                  validator: (value) {  
                    if (value == null || value.isEmpty) {  
                      return 'Please enter your name';  
                    }  
                    return null;  
                  },  
                ),  
                const SizedBox(height: 16),  

                // Email Field  
                TextFormField(  
                  controller: _emailController,  
                  keyboardType: TextInputType.emailAddress,  
                  decoration: InputDecoration(  
                    labelText: 'Email',  
                    prefixIcon: const Icon(Icons.email),  
                    border: OutlineInputBorder(  
                      borderRadius: BorderRadius.circular(12),  
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

                // Password Field  
                TextFormField(  
                  controller: _passwordController,  
                  obscureText: _obscurePassword,  
                  decoration: InputDecoration(  
                    labelText: 'Password',  
                    prefixIcon: const Icon(Icons.lock),  
                    suffixIcon: IconButton(  
                      icon: Icon(  
                        _obscurePassword  
                            ? Icons.visibility_off  
                            : Icons.visibility,  
                      ),  
                      onPressed: () {  
                        setState(() {  
                          _obscurePassword = !_obscurePassword;  
                        });  
                      },  
                    ),  
                    border: OutlineInputBorder(  
                      borderRadius: BorderRadius.circular(12),  
                    ),  
                  ),  
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

                // Confirm Password Field  
                TextFormField(  
                  controller: _confirmPasswordController,  
                  obscureText: _obscureConfirmPassword,  
                  decoration: InputDecoration(  
                    labelText: 'Confirm Password',  
                    prefixIcon: const Icon(Icons.lock),  
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
                    border: OutlineInputBorder(  
                      borderRadius: BorderRadius.circular(12),  
                    ),  
                  ),  
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
                const SizedBox(height: 16),  

                // Terms and Conditions Checkbox  
                Row(  
                  children: [  
                    Checkbox(  
                      value: _acceptedTerms,  
                      onChanged: (value) {  
                        setState(() {  
                          _acceptedTerms = value ?? false;  
                        });  
                      },  
                    ),  
                    Expanded(  
                      child: RichText(  
                        text: TextSpan(  
                          style: TextStyle(  
                            color: Theme.of(context).textTheme.bodyMedium?.color,  
                          ),  
                          children: [  
                            const TextSpan(text: 'I agree to the '),  
                            TextSpan(  
                              text: 'Terms of Service',  
                              style: TextStyle(  
                                color: Theme.of(context).primaryColor,  
                                decoration: TextDecoration.underline,  
                              ),  
                              recognizer: TapGestureRecognizer()  
                                ..onTap = () {  
                                  Navigator.push(  
                                    context,  
                                    MaterialPageRoute(  
                                      builder: (_) => const TermsScreen(),  
                                    ),  
                                  );  
                                },  
                            ),  
                            const TextSpan(text: ' and '),  
                            TextSpan(  
                              text: 'Privacy Policy',  
                              style: TextStyle(  
                                color: Theme.of(context).primaryColor,  
                                decoration: TextDecoration.underline,  
                              ),  
                              recognizer: TapGestureRecognizer()  
                                ..onTap = () {  
                                  Navigator.push(  
                                    context,  
                                    MaterialPageRoute(  
                                      builder: (_) => const PrivacyPolicyScreen(),  
                                    ),  
                                  );  
                                },  
                            ),  
                          ],  
                        ),  
                      ),  
                    ),  
                  ],  
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

                // Register Button  
                CustomButton(  
                  text: 'Create Account',  
                  onPressed: _register,  
                  isLoading: _isLoading,  
                ),  

                // Login Link  
                const SizedBox(height: 16),  
                Row(  
                  mainAxisAlignment: MainAxisAlignment.center,  
                  children: [  
                    const Text('Already have an account?'),  
                    TextButton(  
                      onPressed: () {  
                        Navigator.pushReplacement(  
                          context,  
                          MaterialPageRoute(  
                            builder: (_) => const LoginScreen(),  
                          ),  
                        );  
                      },  
                      child: const Text('Login'),  
                    ),  
                  ],  
                ),  
              ],  
            ),  
          ),  
        ),  
      ),  
    );  
  }  
}