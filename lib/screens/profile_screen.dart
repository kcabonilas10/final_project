// lib/screens/profile_screen.dart  
import 'package:flutter/material.dart';  
import 'package:provider/provider.dart';  
import '../providers/auth_provider.dart';  

class ProfileScreen extends StatelessWidget {  
  static const String routeName = '/profile';  

  const ProfileScreen({super.key});  

  // Add change password dialog  
  void _showChangePasswordDialog(BuildContext context) {  
    final TextEditingController passwordController = TextEditingController();  
    
    showDialog(  
      context: context,  
      builder: (ctx) => AlertDialog(  
        title: const Text('Change Password'),  
        content: TextField(  
          controller: passwordController,  
          decoration: const InputDecoration(  
            labelText: 'New Password',  
          ),  
          obscureText: true,  
        ),  
        actions: [  
          TextButton(  
            onPressed: () {  
              Navigator.of(ctx).pop();  
            },  
            child: const Text('Cancel'),  
          ),  
          FilledButton(  
            onPressed: () async {  
              try {  
                await Provider.of<AuthProvider>(context, listen: false)  
                    .changePassword(passwordController.text);  
                if (context.mounted) {  
                  Navigator.of(ctx).pop();  
                  ScaffoldMessenger.of(context).showSnackBar(  
                    const SnackBar(  
                      content: Text('Password updated successfully!'),  
                    ),  
                  );  
                }  
              } catch (error) {  
                if (context.mounted) {  
                  Navigator.of(ctx).pop();  
                  ScaffoldMessenger.of(context).showSnackBar(  
                    SnackBar(  
                      content: Text(error.toString()),  
                      backgroundColor: Theme.of(context).colorScheme.error,  
                    ),  
                  );  
                }  
              }  
            },  
            child: const Text('Update'),  
          ),  
        ],  
      ),  
    );  
  }  

  // Add delete account dialog  
  void _showDeleteAccountDialog(BuildContext context) {  
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
          FilledButton(  
            onPressed: () async {  
              try {  
                await Provider.of<AuthProvider>(context, listen: false)  
                    .deleteAccount();  
                if (context.mounted) {  
                  Navigator.of(ctx).pop();  
                  Navigator.of(context).pushReplacementNamed('/');  
                }  
              } catch (error) {  
                if (context.mounted) {  
                  Navigator.of(ctx).pop();  
                  ScaffoldMessenger.of(context).showSnackBar(  
                    SnackBar(  
                      content: Text(error.toString()),  
                      backgroundColor: Theme.of(context).colorScheme.error,  
                    ),  
                  );  
                }  
              }  
            },  
            style: FilledButton.styleFrom(  
              backgroundColor: Theme.of(context).colorScheme.error,  
            ),  
            child: const Text('Delete'),  
          ),  
        ],  
      ),  
    );  
  }  

  @override  
  Widget build(BuildContext context) {  
    return Scaffold(  
      appBar: AppBar(  
        title: const Text('My Profile'),  
      ),  
      body: Consumer<AuthProvider>(  
        builder: (context, auth, _) => auth.loading  
            ? const Center(child: CircularProgressIndicator())  
            : ListView(  
                padding: const EdgeInsets.all(16),  
                children: [  
                  // Profile Header  
                  Card(  
                    child: Padding(  
                      padding: const EdgeInsets.all(16),  
                      child: Column(  
                        children: [  
                          CircleAvatar(  
                            radius: 50,  
                            backgroundColor:  
                                Theme.of(context).colorScheme.primary,  
                            backgroundImage: auth.user?.photoURL != null  
                                ? NetworkImage(auth.user!.photoURL!)  
                                : null,  
                            child: auth.user?.photoURL == null  
                                ? const Icon(  
                                    Icons.person,  
                                    size: 50,  
                                    color: Colors.white,  
                                  )  
                                : null,  
                          ),  
                          const SizedBox(height: 16),  
                          Text(  
                            auth.user?.displayName ?? 'User',  
                            style: Theme.of(context).textTheme.titleLarge,  
                          ),  
                          Text(  
                            auth.user?.email ?? '',  
                            style: Theme.of(context).textTheme.bodyMedium,  
                          ),  
                          if (auth.user != null && !auth.user!.emailVerified)  
                            TextButton.icon(  
                              icon: const Icon(Icons.error_outline),  
                              label: const Text('Verify Email'),  
                              onPressed: () async {  
                                try {  
                                  await auth.sendEmailVerification();  
                                  if (context.mounted) {  
                                    ScaffoldMessenger.of(context).showSnackBar(  
                                      const SnackBar(  
                                        content: Text('Verification email sent!'),  
                                      ),  
                                    );  
                                  }  
                                } catch (error) {  
                                  if (context.mounted) {  
                                    ScaffoldMessenger.of(context).showSnackBar(  
                                      SnackBar(  
                                        content: Text(error.toString()),  
                                        backgroundColor:  
                                            Theme.of(context).colorScheme.error,  
                                      ),  
                                    );  
                                  }  
                                }  
                              },  
                            ),  
                        ],  
                      ),  
                    ),  
                  ),  

                  const SizedBox(height: 16),  

                  // Account Settings  
                  Card(  
                    child: Column(  
                      children: [  
                        ListTile(  
                          leading: const Icon(Icons.person_outline),  
                          title: const Text('Edit Profile'),  
                          trailing: const Icon(Icons.chevron_right),  
                          onTap: () {  
                            // Navigate to edit profile screen  
                          },  
                        ),  
                        const Divider(),  
                        ListTile(  
                          leading: const Icon(Icons.lock_outline),  
                          title: const Text('Change Password'),  
                          trailing: const Icon(Icons.chevron_right),  
                          onTap: () {  
                            _showChangePasswordDialog(context);  
                          },  
                        ),  
                      ],  
                    ),  
                  ),  

                  const SizedBox(height: 16),  

                  // App Settings  
                  Card(  
                    child: Column(  
                      children: [  
                        ListTile(  
                          leading: const Icon(Icons.notifications_outlined),  
                          title: const Text('Notifications'),  
                          trailing: Switch(  
                            value: true, // Replace with actual notification setting  
                            onChanged: (value) {  
                              // Implement notification toggle  
                            },  
                          ),  
                        ),  
                        const Divider(),  
                        ListTile(  
                          leading: const Icon(Icons.dark_mode_outlined),  
                          title: const Text('Dark Mode'),  
                          trailing: Switch(  
                            value: Theme.of(context).brightness == Brightness.dark,  
                            onChanged: (value) {  
                              // Implement theme toggle  
                            },  
                          ),  
                        ),  
                      ],  
                    ),  
                  ),  

                  const SizedBox(height: 16),  

                  // Danger Zone  
                  Card(  
                    color: Theme.of(context).colorScheme.errorContainer,  
                    child: Column(  
                      children: [  
                        ListTile(  
                          leading: Icon(  
                            Icons.delete_outline,  
                            color: Theme.of(context).colorScheme.error,  
                          ),  
                          title: Text(  
                            'Delete Account',  
                            style: TextStyle(  
                              color: Theme.of(context).colorScheme.error,  
                            ),  
                          ),  
                          onTap: () {  
                            _showDeleteAccountDialog(context);  
                          },  
                        ),  
                      ],  
                    ),  
                  ),  

                  const SizedBox(height: 16),  

                  // Sign Out Button  
                  FilledButton(  
                    onPressed: () async {  
                      try {  
                        await auth.signOut();  
                        if (context.mounted) {  
                          Navigator.of(context).pushReplacementNamed('/');  
                        }  
                      } catch (error) {  
                        if (context.mounted) {  
                          ScaffoldMessenger.of(context).showSnackBar(  
                            SnackBar(  
                              content: Text(error.toString()),  
                              backgroundColor:  
                                  Theme.of(context).colorScheme.error,  
                            ),  
                          );  
                        }  
                      }  
                    },  
                    style: FilledButton.styleFrom(  
                      backgroundColor: Theme.of(context).colorScheme.error,  
                    ),  
                    child: const Text('Sign Out'),  
                  ),  

                  const SizedBox(height: 32),  
                ],  
              ),  
      ),  
    );  
  }  
}