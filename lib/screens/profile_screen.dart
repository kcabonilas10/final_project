import 'package:flutter/material.dart';  
import 'package:provider/provider.dart';  
import '../providers/auth_provider.dart';  

class ProfileScreen extends StatefulWidget {  
  static const routeName = '/profile';  

  const ProfileScreen({super.key});  

  @override  
  State<ProfileScreen> createState() => _ProfileScreenState();  
}  

class _ProfileScreenState extends State<ProfileScreen> {  
  final _currentPasswordController = TextEditingController();  
  final _newPasswordController = TextEditingController();  
  final _confirmPasswordController = TextEditingController();  
  final _deleteAccountPasswordController = TextEditingController();  

  @override  
  Widget build(BuildContext context) {  
    final auth = Provider.of<AuthProvider>(context);  
    final user = auth.user;  

    if (user == null) {  
      return const Center(child: Text('No user logged in'));  
    }  

    return Scaffold(  
      appBar: AppBar(  
        title: const Text('Profile'),  
      ),  
      body: SingleChildScrollView(  
        padding: const EdgeInsets.all(16.0),  
        child: Column(  
          crossAxisAlignment: CrossAxisAlignment.start,  
          children: [  
            Card(  
              child: Padding(  
                padding: const EdgeInsets.all(16.0),  
                child: Column(  
                  crossAxisAlignment: CrossAxisAlignment.start,  
                  children: [  
                    Text(  
                      'Name: ${user.displayName ?? 'Not set'}',  
                      style: Theme.of(context).textTheme.titleMedium,  
                    ),  
                    const SizedBox(height: 8),  
                    Text(  
                      'Email: ${user.email}',  
                      style: Theme.of(context).textTheme.titleMedium,  
                    ),  
                    const SizedBox(height: 8),  
                    Row(  
                      children: [  
                        Icon(  
                          user.emailVerified  
                              ? Icons.verified  
                              : Icons.warning,  
                          color: user.emailVerified  
                              ? Colors.green  
                              : Colors.orange,  
                        ),  
                        const SizedBox(width: 8),  
                        Text(  
                          user.emailVerified  
                              ? 'Email verified'  
                              : 'Email not verified',  
                          style: TextStyle(  
                            color: user.emailVerified  
                                ? Colors.green  
                                : Colors.orange,  
                          ),  
                        ),  
                        if (!user.emailVerified) ...[  
                          const SizedBox(width: 8),  
                          TextButton(  
                            onPressed: () {  
                              auth.sendEmailVerification(  
                                onSuccess: (message) {  
                                  ScaffoldMessenger.of(context).showSnackBar(  
                                    SnackBar(content: Text(message)),  
                                  );  
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
                            },  
                            child: const Text('Verify now'),  
                          ),  
                        ],  
                      ],  
                    ),  
                  ],  
                ),  
              ),  
            ),  
            const SizedBox(height: 24),  
            Text(  
              'Change Password',  
              style: Theme.of(context).textTheme.titleLarge,  
            ),  
            const SizedBox(height: 16),  
            TextFormField(  
              controller: _currentPasswordController,  
              decoration: const InputDecoration(  
                labelText: 'Current Password',  
                border: OutlineInputBorder(),  
              ),  
              obscureText: true,  
            ),  
            const SizedBox(height: 16),  
            TextFormField(  
              controller: _newPasswordController,  
              decoration: const InputDecoration(  
                labelText: 'New Password',  
                border: OutlineInputBorder(),  
              ),  
              obscureText: true,  
            ),  
            const SizedBox(height: 16),  
            TextFormField(  
              controller: _confirmPasswordController,  
              decoration: const InputDecoration(  
                labelText: 'Confirm New Password',  
                border: OutlineInputBorder(),  
              ),  
              obscureText: true,  
            ),  
            const SizedBox(height: 16),  
            SizedBox(  
              width: double.infinity,  
              child: FilledButton(  
                onPressed: auth.isLoading  
                    ? null  
                    : () {  
                        if (_newPasswordController.text !=  
                            _confirmPasswordController.text) {  
                          ScaffoldMessenger.of(context).showSnackBar(  
                            const SnackBar(  
                              content: Text('New passwords do not match'),  
                              backgroundColor: Colors.red,  
                            ),  
                          );  
                          return;  
                        }  
                        auth.changePassword(  
                          currentPassword: _currentPasswordController.text,  
                          newPassword: _newPasswordController.text,  
                          onSuccess: (message) {  
                            ScaffoldMessenger.of(context).showSnackBar(  
                              SnackBar(content: Text(message)),  
                            );  
                            _currentPasswordController.clear();  
                            _newPasswordController.clear();  
                            _confirmPasswordController.clear();  
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
                    : const Text('Update Password'),  
              ),  
            ),  
            const SizedBox(height: 24),  
            Text(  
              'Delete Account',  
              style: Theme.of(context).textTheme.titleLarge?.copyWith(  
                    color: Colors.red,  
                  ),  
            ),  
            const SizedBox(height: 16),  
            TextFormField(  
              controller: _deleteAccountPasswordController,  
              decoration: const InputDecoration(  
                labelText: 'Confirm Password',  
                border: OutlineInputBorder(),  
              ),  
              obscureText: true,  
            ),  
            const SizedBox(height: 16),  
            SizedBox(  
              width: double.infinity,  
              child: FilledButton(  
                onPressed: auth.isLoading  
                    ? null  
                    : () {  
                        showDialog(  
                          context: context,  
                          builder: (ctx) => AlertDialog(  
                            title: const Text('Delete Account'),  
                            content: const Text(  
                              'Are you sure you want to delete your account? This action cannot be undone.',  
                            ),  
                            actions: [  
                              TextButton(  
                                onPressed: () {  
                                  Navigator.of(ctx).pop();  
                                },  
                                child: const Text('Cancel'),  
                              ),  
                              TextButton(  
                                onPressed: () {  
                                  Navigator.of(ctx).pop();  
                                  auth.deleteAccount(  
                                    password:  
                                        _deleteAccountPasswordController.text,  
                                    onSuccess: (message) {  
                                      ScaffoldMessenger.of(context)  
                                          .showSnackBar(  
                                        SnackBar(content: Text(message)),  
                                      );  
                                      Navigator.of(context)  
                                          .pushReplacementNamed('/');  
                                    },  
                                    onError: (error) {  
                                      ScaffoldMessenger.of(context)  
                                          .showSnackBar(  
                                        SnackBar(  
                                          content: Text(error),  
                                          backgroundColor: Colors.red,  
                                        ),  
                                      );  
                                    },  
                                  );  
                                },  
                                child: const Text(  
                                  'Delete',  
                                  style: TextStyle(color: Colors.red),  
                                ),  
                              ),  
                            ],  
                          ),  
                        );  
                      },  
                style: FilledButton.styleFrom(  
                  backgroundColor: Colors.red,  
                ),  
                child: auth.isLoading  
                    ? const SizedBox(  
                        width: 20,  
                        height: 20,  
                        child: CircularProgressIndicator(  
                          strokeWidth: 2,  
                          color: Colors.white,  
                        ),  
                      )  
                    : const Text('Delete Account'),  
              ),  
            ),  
          ],  
        ),  
      ),  
    );  
  }  

  @override  
  void dispose() {  
    _currentPasswordController.dispose();  
    _newPasswordController.dispose();  
    _confirmPasswordController.dispose();  
    _deleteAccountPasswordController.dispose();  
    super.dispose();  
  }  
}