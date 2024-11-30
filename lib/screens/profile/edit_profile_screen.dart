import 'package:flutter/material.dart';  

class EditProfileScreen extends StatefulWidget {  
  const EditProfileScreen({super.key});  

  @override  
  State<EditProfileScreen> createState() => _EditProfileScreenState();  
}  

class _EditProfileScreenState extends State<EditProfileScreen> {  
  final _formKey = GlobalKey<FormState>();  
  final _nameController = TextEditingController();  
  final _emailController = TextEditingController();  
  final _phoneController = TextEditingController();  

  @override  
  void initState() {  
    super.initState();  
    // Initialize controllers with user data  
    _nameController.text = 'John Doe';  
    _emailController.text = 'john.doe@example.com';  
    _phoneController.text = '+1234567890';  
  }  

  @override  
  void dispose() {  
    _nameController.dispose();  
    _emailController.dispose();  
    _phoneController.dispose();  
    super.dispose();  
  }  

  @override  
  Widget build(BuildContext context) {  
    return Scaffold(  
      appBar: AppBar(  
        title: const Text('Edit Profile'),  
        actions: [  
          TextButton(  
            onPressed: () {  
              if (_formKey.currentState?.validate() ?? false) {  
                // Save profile changes  
                Navigator.pop(context);  
              }  
            },  
            child: const Text('Save'),  
          ),  
        ],  
      ),  
      body: SingleChildScrollView(  
        padding: const EdgeInsets.all(16),  
        child: Form(  
          key: _formKey,  
          child: Column(  
            children: [  
              Stack(  
                alignment: Alignment.bottomRight,  
                children: [  
                  const CircleAvatar(  
                    radius: 50,  
                    backgroundImage: NetworkImage('https://via.placeholder.com/100'),  
                  ),  
                  Container(  
                    decoration: BoxDecoration(  
                      color: Theme.of(context).colorScheme.primary,  
                      shape: BoxShape.circle,  
                    ),  
                    child: IconButton(  
                      icon: const Icon(Icons.camera_alt, color: Colors.white),  
                      onPressed: () {  
                        // Implement image picker  
                      },  
                    ),  
                  ),  
                ],  
              ),  
              const SizedBox(height: 24),  
              TextFormField(  
                controller: _nameController,  
                decoration: const InputDecoration(  
                  labelText: 'Full Name',  
                  prefixIcon: Icon(Icons.person),  
                ),  
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
                controller: _phoneController,  
                decoration: const InputDecoration(  
                  labelText: 'Phone Number',  
                  prefixIcon: Icon(Icons.phone),  
                ),  
                validator: (value) {  
                  if (value == null || value.isEmpty) {  
                    return 'Please enter your phone number';  
                  }  
                  return null;  
                },  
              ),  
            ],  
          ),  
        ),  
      ),  
    );  
  }  
}