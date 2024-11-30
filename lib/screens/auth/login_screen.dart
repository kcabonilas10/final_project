// lib/screens/auth/login_screen.dart  
import 'package:flutter/material.dart';  
import 'package:provider/provider.dart';  
import '../../providers/auth_provider.dart';  
import '../home_screen.dart';  

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
  bool _isPasswordVisible = false;  
  bool _rememberMe = false;  

  @override  
  void dispose() {  
    _emailController.dispose();  
    _passwordController.dispose();  
    super.dispose();  
  }  

  Future<void> _submit() async {  
    if (!_formKey.currentState!.validate()) {  
      return;  
    }  

    try {  
      await Provider.of<AuthProvider>(context, listen: false).signIn(  
        email: _emailController.text,  
        password: _passwordController.text,  
      );  

      if (!mounted) return;  

      // On successful login, navigate to home screen  
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);  
      
    } catch (error) {  
      // Show error message  
      if (!mounted) return;  
      ScaffoldMessenger.of(context).showSnackBar(  
        SnackBar(  
          content: Text(error.toString()),  
          backgroundColor: Colors.red,  
        ),  
      );  
    }  
  }  

  Future<void> _forgotPassword() async {  
    try {  
      await Provider.of<AuthProvider>(context, listen: false)  
          .sendPasswordResetEmail(_emailController.text);  

      if (!mounted) return;  
      
      ScaffoldMessenger.of(context).showSnackBar(  
        const SnackBar(  
          content: Text('Password reset email sent. Please check your inbox.'),  
          backgroundColor: Colors.green,  
        ),  
      );  
    } catch (error) {  
      if (!mounted) return;  
      ScaffoldMessenger.of(context).showSnackBar(  
        SnackBar(  
          content: Text(error.toString()),  
          backgroundColor: Colors.red,  
        ),  
      );  
    }  
  }  

  @override  
  Widget build(BuildContext context) {  
    return Scaffold(  
      body: SafeArea(  
        child: Center(  
          child: SingleChildScrollView(  
            padding: const EdgeInsets.all(24),  
            child: Column(  
              mainAxisAlignment: MainAxisAlignment.center,  
              crossAxisAlignment: CrossAxisAlignment.stretch,  
              children: [  
                Text(  
                  'Welcome Back!',  
                  style: Theme.of(context).textTheme.headlineMedium,  
                  textAlign: TextAlign.center,  
                ),  
                const SizedBox(height: 8),  
                Text(  
                  'Sign in to continue shopping',  
                  style: Theme.of(context).textTheme.bodyLarge,  
                  textAlign: TextAlign.center,  
                ),  
                const SizedBox(height: 32),  
                Form(  
                  key: _formKey,  
                  child: Column(  
                    children: [  
                      TextFormField(  
                        controller: _emailController,  
                        keyboardType: TextInputType.emailAddress,  
                        decoration: const InputDecoration(  
                          labelText: 'Email',  
                          hintText: 'Enter your email',  
                          prefixIcon: Icon(Icons.email),  
                        ),  
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
                        obscureText: !_isPasswordVisible,  
                        decoration: InputDecoration(  
                          labelText: 'Password',  
                          hintText: 'Enter your password',  
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
                            return 'Please enter your password';  
                          }  
                          if (value.length < 6) {  
                            return 'Password must be at least 6 characters';  
                          }  
                          return null;  
                        },  
                      ),  
                      const SizedBox(height: 16),  
                      Row(  
                        children: [  
                          Checkbox(  
                            value: _rememberMe,  
                            onChanged: (value) {  
                              setState(() {  
                                _rememberMe = value ?? false;  
                              });  
                            },  
                          ),  
                          const Text('Remember me'),  
                          const Spacer(),  
                          TextButton(  
                            onPressed: _emailController.text.isEmpty  
                                ? null  
                                : _forgotPassword,  
                            child: const Text('Forgot Password?'),  
                          ),  
                        ],  
                      ),  
                      const SizedBox(height: 24),  
                      Consumer<AuthProvider>(  
                        builder: (ctx, auth, _) => SizedBox(  
                          width: double.infinity,  
                          child: FilledButton(  
                            onPressed: auth.loading ? null : _submit,  
                            child: auth.loading  
                                ? const SizedBox(  
                                    height: 20,  
                                    width: 20,  
                                    child: CircularProgressIndicator(  
                                      strokeWidth: 2,  
                                      color: Colors.white,  
                                    ),  
                                  )  
                                : const Text('Login'),  
                          ),  
                        ),  
                      ),  
                      const SizedBox(height: 16),  
                      Row(  
                        mainAxisAlignment: MainAxisAlignment.center,  
                        children: [  
                          const Text("Don't have an account?"),  
                          TextButton(  
                            onPressed: () {  
                              Navigator.pushNamed(context, '/register');  
                            },  
                            child: const Text('Sign Up'),  
                          ),  
                        ],  
                      ),  
                    ],  
                  ),  
                ),  
              ],  
            ),  
          ),  
        ),  
      ),  
    );  
  }  
}