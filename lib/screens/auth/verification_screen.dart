// lib/screens/auth/verification_screen.dart  
import 'package:flutter/material.dart';  
import 'package:logger/logger.dart';  
import '../../screens/home_screen.dart';  // Updated import path  

// Create a logger instance  
final _logger = Logger(  
  printer: PrettyPrinter(  
    methodCount: 0,  
    errorMethodCount: 5,  
    lineLength: 50,  
    colors: true,  
    printEmojis: true,  
    dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,  // Updated from printTime  
  ),  
);  

class VerificationScreen extends StatefulWidget {  
  static const routeName = '/verification';  

  const VerificationScreen({super.key});  

  @override  
  State<VerificationScreen> createState() => _VerificationScreenState();  
}  

class _VerificationScreenState extends State<VerificationScreen> {  
  final _formKey = GlobalKey<FormState>();  
  final _codeController = TextEditingController();  
  bool _isLoading = false;  

  @override  
  void dispose() {  
    _codeController.dispose();  
    super.dispose();  
  }  

  Future<void> _verifyCode() async {  
    if (!_formKey.currentState!.validate()) {  
      return;  
    }  

    setState(() {  
      _isLoading = true;  
    });  

    try {  
      // Replace this with your actual verification logic  
      final code = _codeController.text.trim();  
      _logger.i('Verifying code: $code');  

      // Simulate verification delay  
      await Future.delayed(const Duration(seconds: 2));  

      // Navigate to home screen on success  
      if (mounted) {  
        Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);  
      }  
    } catch (error) {  
      _logger.e('Verification error:', error: error, stackTrace: StackTrace.current);  
      
      if (mounted) {  
        ScaffoldMessenger.of(context).showSnackBar(  
          SnackBar(  
            content: const Text('Verification failed. Please try again.'),  
            backgroundColor: Theme.of(context).colorScheme.error,  
          ),  
        );  
      }  
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
        title: const Text('Verify Your Account'),  
      ),  
      body: SafeArea(  
        child: Padding(  
          padding: const EdgeInsets.all(16.0),  
          child: Form(  
            key: _formKey,  
            child: Column(  
              mainAxisAlignment: MainAxisAlignment.center,  
              crossAxisAlignment: CrossAxisAlignment.stretch,  
              children: [  
                Text(  
                  'Enter Verification Code',  
                  style: Theme.of(context).textTheme.headlineSmall,  
                  textAlign: TextAlign.center,  
                ),  
                const SizedBox(height: 16),  
                Text(  
                  'We have sent a verification code to your email address.',  
                  style: Theme.of(context).textTheme.bodyLarge,  
                  textAlign: TextAlign.center,  
                ),  
                const SizedBox(height: 32),  
                TextFormField(  
                  controller: _codeController,  
                  decoration: const InputDecoration(  
                    labelText: 'Verification Code',  
                    hintText: 'Enter the 6-digit code',  
                  ),  
                  keyboardType: TextInputType.number,  
                  maxLength: 6,  
                  textAlign: TextAlign.center,  
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(  
                        letterSpacing: 8,  
                        fontWeight: FontWeight.bold,  
                      ),  
                  validator: (value) {  
                    if (value == null || value.isEmpty) {  
                      return 'Please enter the verification code';  
                    }  
                    if (value.length != 6) {  
                      return 'Code must be 6 digits';  
                    }  
                    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {  
                      return 'Code must contain only numbers';  
                    }  
                    return null;  
                  },  
                ),  
                const SizedBox(height: 32),  
                FilledButton(  
                  onPressed: _isLoading ? null : _verifyCode,  
                  child: _isLoading  
                      ? const SizedBox(  
                          height: 20,  
                          width: 20,  
                          child: CircularProgressIndicator(  
                            strokeWidth: 2,  
                          ),  
                        )  
                      : const Text('Verify'),  
                ),  
                const SizedBox(height: 16),  
                TextButton(  
                  onPressed: _isLoading  
                      ? null  
                      : () {  
                          _logger.i('Resending verification code');  
                          ScaffoldMessenger.of(context).showSnackBar(  
                            const SnackBar(  
                              content: Text('New code sent to your email'),  
                            ),  
                          );  
                        },  
                  child: const Text('Resend Code'),  
                ),  
              ],  
            ),  
          ),  
        ),  
      ),  
    );  
  }  
}