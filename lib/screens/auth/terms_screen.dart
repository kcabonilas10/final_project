import 'package:flutter/material.dart';  

class TermsScreen extends StatelessWidget {  
  const TermsScreen({super.key});  

  @override  
  Widget build(BuildContext context) {  
    return Scaffold(  
      appBar: AppBar(  
        title: const Text('Terms of Service'),  
      ),  
      body: SingleChildScrollView(  
        padding: const EdgeInsets.all(16.0),  
        child: Column(  
          crossAxisAlignment: CrossAxisAlignment.start,  
          children: [  
            Text(  
              'Terms of Service',  
              style: Theme.of(context).textTheme.headlineMedium,  
            ),  
            const SizedBox(height: 16),  
            const Text(  
              'Last updated: November 30, 2024\n\n'  
              '1. Acceptance of Terms\n\n'  
              'By accessing and using this application, you accept and agree to be bound by the terms and provision of this agreement.\n\n'  
              '2. Use License\n\n'  
              'Permission is granted to temporarily download one copy of the application for personal, non-commercial transitory viewing only.\n\n'  
              '3. Disclaimer\n\n'  
              'The materials on the application are provided on an \'as is\' basis. We make no warranties, expressed or implied, and hereby disclaim and negate all other warranties including, without limitation, implied warranties or conditions of merchantability, fitness for a particular purpose, or non-infringement of intellectual property or other violation of rights.\n\n'  
              '4. Limitations\n\n'  
              'In no event shall we or our suppliers be liable for any damages (including, without limitation, damages for loss of data or profit, or due to business interruption) arising out of the use or inability to use the materials on the application.\n\n'  
              '5. Revisions and Errata\n\n'  
              'The materials appearing on the application could include technical, typographical, or photographic errors. We do not warrant that any of the materials on the application are accurate, complete or current.\n\n'  
              '6. Links\n\n'  
              'We have not reviewed all of the sites linked to our application and are not responsible for the contents of any such linked site.\n\n'  
              '7. Modifications\n\n'  
              'We may revise these terms of service for the application at any time without notice.',  
              style: TextStyle(height: 1.5),  
            ),  
          ],  
        ),  
      ),  
    );  
  }  
}