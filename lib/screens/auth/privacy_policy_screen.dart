import 'package:flutter/material.dart';  

class PrivacyPolicyScreen extends StatelessWidget {  
  const PrivacyPolicyScreen({super.key});  

  @override  
  Widget build(BuildContext context) {  
    return Scaffold(  
      appBar: AppBar(  
        title: const Text('Privacy Policy'),  
      ),  
      body: SingleChildScrollView(  
        padding: const EdgeInsets.all(16.0),  
        child: Column(  
          crossAxisAlignment: CrossAxisAlignment.start,  
          children: [  
            Text(  
              'Privacy Policy',  
              style: Theme.of(context).textTheme.headlineMedium,  
            ),  
            const SizedBox(height: 16),  
            const Text(  
              'Last updated: November 30, 2024\n\n'  
              '1. Information We Collect\n\n'  
              'We collect information that you provide directly to us, including:\n'  
              '• Name\n'  
              '• Email address\n'  
              '• Password\n'  
              '• Other information you choose to provide\n\n'  
              '2. How We Use Your Information\n\n'  
              'We use the information we collect to:\n'  
              '• Provide, maintain, and improve our services\n'  
              '• Process your transactions\n'  
              '• Send you technical notices and support messages\n'  
              '• Communicate with you about products, services, and events\n\n'  
              '3. Information Sharing\n\n'  
              'We do not share your personal information with third parties except as described in this privacy policy.\n\n'  
              '4. Data Security\n\n'  
              'We take reasonable measures to help protect your personal information from loss, theft, misuse, unauthorized access, disclosure, alteration, and destruction.\n\n'  
              '5. Your Rights\n\n'  
              'You have the right to:\n'  
              '• Access your personal information\n'  
              '• Correct inaccurate information\n'  
              '• Request deletion of your information\n'  
              '• Object to processing of your information\n\n'  
              '6. Changes to This Policy\n\n'  
              'We may update this privacy policy from time to time. We will notify you of any changes by posting the new privacy policy on this page.',  
              style: TextStyle(height: 1.5),  
            ),  
          ],  
        ),  
      ),  
    );  
  }  
}