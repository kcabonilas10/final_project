import 'package:flutter/material.dart';  

class LoadingIndicator extends StatelessWidget {  
  final String? message;  

  const LoadingIndicator({  
    super.key,  
    this.message,  
  });  

  @override  
  Widget build(BuildContext context) {  
    return Center(  
      child: Column(  
        mainAxisSize: MainAxisSize.min,  
        children: [  
          CircularProgressIndicator(  
            color: Theme.of(context).colorScheme.primary,  
          ),  
          if (message != null) ...[  
            const SizedBox(height: 16),  
            Text(  
              message!,  
              style: Theme.of(context).textTheme.bodyLarge,  
              textAlign: TextAlign.center,  
            ),  
          ],  
        ],  
      ),  
    );  
  }  
}