import 'package:flutter/material.dart';  
import 'package:provider/provider.dart';  
import '../../providers/auth_provider.dart';  
import 'forgot_password_screen.dart';  

class LoginScreen extends StatefulWidget {  
  static const routeName = '/login';  

  const LoginScreen({super.key});  

  @override  
  State<LoginScreen> createState() => _LoginScreenState();  
}  

class _LoginScreenState extends State<LoginScreen> {  
  final _formKey = GlobalKey<FormState>();  
  final _emailController = TextEditingController();  
  final _passwordController = TextEditingController();  
  bool _obscurePassword = true;  

  @override  
  Widget build(BuildContext context) {  
    return Scaffold(  
      appBar: AppBar(  
        title: const Text('Login'),  
      ),  
      body: Padding(  
        padding: const EdgeInsets.all(16.0),  
        child: Form(  
          key: _formKey,  
          child: Column(  
            mainAxisAlignment: MainAxisAlignment.center,  
            children: [  
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
                ),  
                obscureText: _obscurePassword,  
                validator: (value) {  
                  if (value == null || value.isEmpty) {  
                    return 'Please enter your password';  
                  }  
                  if (value.length < 6) {  
                    return 'Password must be at least 6 characters';  
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
                              auth.signIn(  
                                email: _emailController.text,  
                                password: _passwordController.text,  
                                onSuccess: (message) {  
                                  ScaffoldMessenger.of(context).showSnackBar(  
                                    SnackBar(content: Text(message)),  
                                  );  
                                  Navigator.of(context).pushReplacementNamed('/home');  
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
                        : const Text('Login'),  
                  );  
                },  
              ),  
              const SizedBox(height: 16),  
              TextButton(  
                onPressed: () {  
                  Navigator.of(context)  
                      .pushNamed(ForgotPasswordScreen.routeName);  
                },  
                child: const Text('Forgot Password?'),  
              ),  
            ],  
          ),  
        ),  
      ),  
    );  
  }  

  @override  
  void dispose() {  
    _emailController.dispose();  
    _passwordController.dispose();  
    super.dispose();  
  }  
}