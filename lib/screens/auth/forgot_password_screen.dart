import 'package:flutter/material.dart';  
import 'package:provider/provider.dart';  
import '../../providers/auth_provider.dart';  

class ForgotPasswordScreen extends StatefulWidget {  
  static const routeName = '/forgot-password';  

  const ForgotPasswordScreen({super.key});  

  @override  
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();  
}  

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {  
  final _emailController = TextEditingController();  
  final _formKey = GlobalKey<FormState>();  

  @override  
  Widget build(BuildContext context) {  
    return Scaffold(  
      appBar: AppBar(  
        title: const Text('Reset Password'),  
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
              const SizedBox(height: 24),  
              Consumer<AuthProvider>(  
                builder: (context, auth, _) {  
                  return FilledButton(  
                    onPressed: auth.isLoading  
                        ? null  
                        : () {  
                            if (_formKey.currentState!.validate()) {  
                              auth.sendPasswordResetEmail(  
                                email: _emailController.text,  
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
                        : const Text('Send Reset Link'),  
                  );  
                },  
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
    super.dispose();  
  }  
}