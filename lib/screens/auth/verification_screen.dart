// lib/screens/auth/verification_screen.dart  
import 'package:flutter/material.dart';  
import 'package:provider/provider.dart';  
import '../../providers/auth_provider.dart';  
import '../home_screen.dart';  

class VerificationScreen extends StatefulWidget {  
  static const routeName = '/verification';  

  const VerificationScreen({super.key});  

  @override  
  State<VerificationScreen> createState() => _VerificationScreenState();  
}  

class _VerificationScreenState extends State<VerificationScreen> {  
  final _phoneController = TextEditingController();  
  final _otpController = TextEditingController();  
  String? _verificationId;  
  bool _codeSent = false;  

  void _verifyPhone() {  
    if (_phoneController.text.isEmpty) return;  

    final authProvider = Provider.of<AuthProvider>(context, listen: false);  
    authProvider.verifyPhoneNumber(  
      phoneNumber: _phoneController.text,  
      onCodeSent: (String verificationId) {  
        setState(() {  
          _verificationId = verificationId;  
          _codeSent = true;  
        });  
      },  
      onError: (String error) {  
        ScaffoldMessenger.of(context).showSnackBar(  
          SnackBar(content: Text(error)),  
        );  
      },  
    );  
  }  

  void _verifyOTP() {  
    if (_otpController.text.isEmpty || _verificationId == null) return;  

    final authProvider = Provider.of<AuthProvider>(context, listen: false);  
    authProvider.verifyOTP(  
      verificationId: _verificationId!,  
      otp: _otpController.text,  
      onError: (String error) {  
        ScaffoldMessenger.of(context).showSnackBar(  
          SnackBar(content: Text(error)),  
        );  
      },  
    );  
  }  

  @override  
  Widget build(BuildContext context) {  
    return Scaffold(  
      appBar: AppBar(  
        title: Text(_codeSent ? 'Enter OTP' : 'Phone Verification'),  
      ),  
      body: Consumer<AuthProvider>(  
        builder: (context, authProvider, _) {  
          if (authProvider.isAuthenticated) {  
            Future.microtask(() =>   
              Navigator.of(context).pushReplacementNamed(HomeScreen.routeName)  
            );  
          }  

          return Padding(  
            padding: const EdgeInsets.all(16.0),  
            child: Column(  
              mainAxisAlignment: MainAxisAlignment.center,  
              children: [  
                if (!_codeSent) ...[  
                  TextField(  
                    controller: _phoneController,  
                    decoration: const InputDecoration(  
                      labelText: 'Phone Number',  
                      hintText: '+1234567890',  
                    ),  
                    keyboardType: TextInputType.phone,  
                  ),  
                  const SizedBox(height: 16),  
                  FilledButton(  
                    onPressed: authProvider.isLoading ? null : _verifyPhone,  
                    child: authProvider.isLoading  
                        ? const CircularProgressIndicator()  
                        : const Text('Send OTP'),  
                  ),  
                ] else ...[  
                  TextField(  
                    controller: _otpController,  
                    decoration: const InputDecoration(  
                      labelText: 'OTP Code',  
                      hintText: '123456',  
                    ),  
                    keyboardType: TextInputType.number,  
                  ),  
                  const SizedBox(height: 16),  
                  FilledButton(  
                    onPressed: authProvider.isLoading ? null : _verifyOTP,  
                    child: authProvider.isLoading  
                        ? const CircularProgressIndicator()  
                        : const Text('Verify OTP'),  
                  ),  
                ],  
              ],  
            ),  
          );  
        },  
      ),  
    );  
  }  

  @override  
  void dispose() {  
    _phoneController.dispose();  
    _otpController.dispose();  
    super.dispose();  
  }  
}