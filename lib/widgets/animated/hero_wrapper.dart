import 'package:flutter/material.dart';  

class HeroWrapper extends StatelessWidget {  
  final String tag;  
  final Widget child;  
  final bool enabled;  

  const HeroWrapper({  
    super.key,  
    required this.tag,  
    required this.child,  
    this.enabled = true,  
  });  

  @override  
  Widget build(BuildContext context) {  
    if (!enabled) return child;  
    
    return Hero(  
      tag: tag,  
      child: Material(  
        type: MaterialType.transparency,  
        child: child,  
      ),  
    );  
  }  
}